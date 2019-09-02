//
//  cbondFetch.swift
//  BondsCashFlow
//
//  Created by Igor Malyarov on 25.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import Foundation

extension UpdateLocalDataSection {
    enum CBondError: Error {
        case incorrectOperation, notOkResponse, decodingError, writeToFileError
    }
    
    //  MARK: - TODO: add filters to query
    //  MARK: - TODO: finish coding background operation
    
    func cbondFetch(login: String = "igor@rbiz.group",
                    password: String = "bonmaM-wojhed-fokza3",
                    filters: String,
                    limit: Int = 10,
                    offset: Int = 0,
                    cbondOperation: String = "get_flow",
                    background: Bool = false) throws {
        
        //  could handle just "get_flow" (потоки платежей) or "get_emissions" (параметры эмиссий)
        if !(cbondOperation == "get_flow" || cbondOperation == "get_emissions") {
            print("incorrect cbond operation")
            throw CBondError.incorrectOperation
        }
        
        
        let url = URL(string: "https://ws.cbonds.info/services/json/" + cbondOperation + "/")!
        var request = URLRequest(url: url)
        request.httpMethod = "Post"
        
        let json = "{\"auth\":{\"login\":\"\(login)\",\"password\":\"\(password)\"},\(filters)\"quantity\":{\"limit\":" + String(limit) + ",\"offset\":" + String(offset) + "}}"
        request.httpBody = json.data(using: .utf8)
        
        
        //  MARK: - TODO: finish coding background operation
        let session = cbondSession(background: background)
        let task = session.dataTask(with: request) {
            
            (data, response, error) in
            
            if let error = error {
                print(error.localizedDescription)
                self.handleCBondError(error)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200,
                let data = data else {
                    print("httpResponse statusCode IS NOT 200")
                    self.handleCBondError(CBondError.notOkResponse)
                    return
            }
            
            self.parseAndSave(data, cbondOperation: cbondOperation)
            
            DispatchQueue.main.async {
                //  MARK: - Update UI from main thread!
                self.requestCompletedOK()
            }
        }
        
        task.resume()
    }
    
    
    fileprivate func cbondSession(background: Bool = false) -> URLSession {
        // MARK:- что еще для background operation??
        if background {
            let backgroundConfiguration = URLSessionConfiguration.background(withIdentifier: "com.photoigor.bondscashflow.cbonds")
            return URLSession(configuration: backgroundConfiguration)
        } else {
            return URLSession(configuration: .default)
        }
    }
    
    
    fileprivate func parseAndSave(_ data: Data, cbondOperation: String) {
        
        //  encode and store fetched data locally
        guard let postResponse = String(data: data, encoding: .utf8) else {
            print("Error encoding CBond data.")
            return
        }
        let jsonURL = URL(fileURLWithPath: cbondOperation,
                          relativeTo: FileManager.documentDirectoryURL)
            .appendingPathExtension("json")
        try! postResponse.write(to: jsonURL, atomically: true, encoding: .utf8)
        // print(postResponse)
        print("CBond data URL: \(jsonURL)")
        print("On main thread? " + (Thread.current.isMainThread ? "Yes" : "No"))
        
        //  create JSON decoder and encoder
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(.cbondDateFormatter)
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        //  prepare filename ("emissions" or "flow") and URL in Document Directory
        let filename = String(cbondOperation.split(separator: "_", maxSplits: 1)[1])
        let filenameURL = URL(fileURLWithPath: filename,
                              relativeTo: FileManager.documentDirectoryURL)
            .appendingPathExtension("json")
        
        
        //  parse fetched data according to request
        
        if cbondOperation == "get_emissions" {   //  get_emissions (параметры эмиссий)
            do {
                //  decode and take just the data we want
                let cbondEmission = try decoder.decode(CBondGetEmission.self, from: data)
                let emissionStructure = cbondEmission.items.map({ EmissionStructure(from: $0) })
                    .removingDuplicates()
                
                //  MARK: - TODO: parse header - could be valuable info there
                //  ...
                //  TODO: parse header - could be valuable info there
                //        to be used to check if request is needed
                print("count: \(cbondEmission.count), total: \(cbondEmission.total), execTime: \(cbondEmission.execTime)")
                
                
                //  encode and store useful data locally
                let usefulData = try encoder.encode(emissionStructure)
                try usefulData.write(to: filenameURL)
                
                print("fetched data parsed, optimized and saved\n" +
                    "emissionStructure.count: \(emissionStructure.count)")
            } catch {
                print(error.localizedDescription)
            }
        }
        
        if cbondOperation == "get_flow" {    //  get_flow (потоки платежей)
            do {
                //  decode and take just the data we want
                let cbondFlow = try decoder.decode(CBondGetFlow.self, from: data)
                let cashFlowStructure = cbondFlow.items.map({ CashFlowStructure(from: $0) })
                    .removingDuplicates()
                
                //  MARK: - TODO: parse header - could be valuable info there
                //  ...
                //  TODO: parse header - could be valuable info there
                //        to be used to check if request is needed
                print("count: \(cbondFlow.count), total: \(cbondFlow.total), execTime: \(cbondFlow.execTime)")
                
                
                //  encode and store useful data locally
                let usefulData = try encoder.encode(cashFlowStructure)
                try usefulData.write(to: filenameURL)
                
                print("fetched data parsed, optimized and saved\n" +
                    "cashFlowStructure.count: \(cashFlowStructure.count)")
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

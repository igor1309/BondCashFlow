//
//  cbondFetch.swift
//  BondsCashFlow
//
//  Created by Igor Malyarov on 25.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import Foundation

extension UpdateLocalDataSection {
    
    //  MARK: - TODO: finish coding background operation
    // https://developer.apple.com/documentation/foundation/url_loading_system/downloading_files_in_the_background
    fileprivate func cbondSession(background: Bool = false) -> URLSession {
        // MARK: что еще для background operation??
        if background {
            let backgroundConfiguration = URLSessionConfiguration.background(withIdentifier: "com.photoigor.bondscashflow.cbonds")
            return URLSession(configuration: backgroundConfiguration)
        } else {
            return URLSession(configuration: .default)
        }
    }
    
    enum CBondError: Error {
        case incorrectOperation, notOkResponse, decodingError, writeToFileError
    }
    
    func cbondSmartFetch(login: String = "igor@rbiz.group",
                         password: String = "bonmaM-wojhed-fokza3",
                         filters: String,
                         limit: Int = 10,
                         offset: Int = 0,
                         cbondOperation: String = "get_flow",
                         background: Bool = false)
        throws {
            
            let request = try cbondRequest(login: login,
                                           password: password,
                                           filters: filters,
                                           limit: limit,
                                           offset: offset,
                                           cbondOperation: cbondOperation)
            let session = cbondSession(background: background)
            let task = session.dataTask(with: request) { result in
                
                switch result {
                case .success:
                    
                    //  parse fetched data according to request
                    
                    if cbondOperation == "get_emissions" {   //  get_emissions (параметры эмиссий)
                        do {
                            let cbondGetEmission: CBondGetEmission = try result.cbondDecoded()
                            
                            //  MARK: Update UI from main thread!
                            DispatchQueue.main.async {
                                self.userData.emissionMetadata = CBondEmissionMetadata(from: cbondGetEmission)
                                self.userData.emissions = cbondGetEmission.items.map({ Emission(from: $0) })
                                self.requestCompletedOK()
                            }
                        } catch {
                            print(error.localizedDescription)
                            self.handleCBondError(error)
                        }
                    }
                    
                    if cbondOperation == "get_flow" {    //  get_flow (потоки платежей)
                        do {
                            let cbondGetFlow: CBondGetFlow = try result.cbondDecoded()
                            
                            //  MARK: Update UI from main thread!
                            DispatchQueue.main.async {
                                self.userData.flowMetadata = CBondFlowMetadata(from: cbondGetFlow)
                                self.userData.flows = cbondGetFlow.items.map({ Flow(from: $0) })
                                self.requestCompletedOK()
                            }
                        } catch let error {
                            print(error.localizedDescription)
                            self.handleCBondError(error)
                        }
                    }
                    break
                    
                case .failure(let error):
                    DispatchQueue.main.async {
                        //  MARK: Update UI from main thread!
                        self.handleCBondError(error)
                    }
                    break
                }
            }
            task.resume()
    }
    
    
    func cbondSmartFetchBoth(login: String = "igor@rbiz.group",
                             password: String = "bonmaM-wojhed-fokza3",
                             filters: String,
                             limit: Int = 10,
                             offset: Int = 0,
                             background: Bool = false)
        throws {
            
            let request1 = try cbondRequest(login: login,
                                            password: password,
                                            filters: filters,
                                            limit: limit,
                                            offset: offset,
                                            cbondOperation: "get_emissions")
            let request2 = try cbondRequest(login: login,
                                            password: password,
                                            filters: filters,
                                            limit: limit,
                                            offset: offset,
                                            cbondOperation: "get_flow")
            
            let session = cbondSession(background: background)
            
            group.enter()
            
            let task1 = session.dataTask(with: request1) { result in    //  get_emissions
                
                switch result {
                case .success:
                    do {
                        let cbondGetEmission: CBondGetEmission = try result.cbondDecoded()
                        
                        //  MARK: Update UI from main thread!
                        DispatchQueue.main.async {
                            self.userData.emissionMetadata = CBondEmissionMetadata(from: cbondGetEmission)
                            self.userData.emissions = cbondGetEmission.items.map({ Emission(from: $0) })
                            
                            self.group.leave()
                        }
                    } catch {
                        print(error.localizedDescription)
                        self.handleCBondError(error)
                    }
                    break
                    
                case .failure(let error):
                    DispatchQueue.main.async {
                        //  MARK: Update UI from main thread!
                        self.handleCBondError(error)
                    }
                    break
                }
            }
            task1.resume()
            
            group.enter()
            
            let task2 = session.dataTask(with: request2) { result in    //  get_flow
                
                switch result {
                case .success:
                    do {
                        let cbondGetFlow: CBondGetFlow = try result.cbondDecoded()
                        
                        //  MARK: Update UI from main thread!
                        DispatchQueue.main.async {
                            self.userData.flowMetadata = CBondFlowMetadata(from: cbondGetFlow)
                            self.userData.flows = cbondGetFlow.items.map({ Flow(from: $0) })
                            
                            self.group.leave()
                        }
                    } catch let error {
                        print(error.localizedDescription)
                        self.handleCBondError(error)
                    }
                    break
                    
                case .failure(let error):
                    DispatchQueue.main.async {
                        //  MARK: Update UI from main thread!
                        self.handleCBondError(error)
                    }
                    break
                }
            }
            task2.resume()
            
            group.notify(queue: .main) {
                DispatchQueue.main.async {
                    print("\n\n\nDONE")
                    self.requestCompletedOK()
                }
            }
    }
}

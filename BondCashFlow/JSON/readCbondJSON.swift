//
//  readCbondJSON.swift
//  BondsCashFlow
//
//  Created by Igor Malyarov on 25.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import Foundation

enum ReadingJSONError: Error {
    case readingCbondJSONError
}

func readCbondJSON<T: Decodable>(from filename: String, as type: T.Type = T.self) -> T? {
    let jsonDecoder = JSONDecoder()
    jsonDecoder.dateDecodingStrategy = .formatted(.cbondDateFormatter)
    
    let jsonURL = URL(fileURLWithPath: filename,
                      relativeTo: FileManager.documentDirectoryURL).appendingPathExtension("json")
    
    do {
        let savedJSONData = try Data(contentsOf: jsonURL)
        return try jsonDecoder.decode(T.self, from: savedJSONData)
    } catch let error {
        print(error)
        return nil
    }
}

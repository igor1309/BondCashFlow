//
//  Result+Extension.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 03.09.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import Foundation

extension Result where Success == Data {

    //  https://mecid.github.io/2019/04/17/asynchronous-completion-handlers-with-result-type/
    func decode<T: Decodable>(with decoder: JSONDecoder = .init()) -> Result<T, Error> {
        do {
            let data = try get()
            let decoded = try decoder.decode(T.self, from: data)
            return .success(decoded)
        } catch {
            return .failure(error)
        }
    }
    
    //  https://swiftbysundell.net/articles/the-power-of-result-types-in-swift/
    func decoded<T: Decodable>(
        using decoder: JSONDecoder = .init()
    ) throws -> T {
        let data = try get()
        return try decoder.decode(T.self, from: data)
    }
}

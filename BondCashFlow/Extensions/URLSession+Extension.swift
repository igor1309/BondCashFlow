//
//  URLSession+Extension.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 02.09.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import Foundation

typealias Handler<T> = (Result<T, Error>) -> Void

extension URLSession {
    func dataTask(with url: URLRequest, completionHandler: @escaping Handler<Data>) -> URLSessionDataTask{
        dataTask(with: url) { data, _, error in
            if let error = error {
                completionHandler(.failure(error))
            } else {
                completionHandler(.success(data ?? Data()))
            }
        }
    }
}

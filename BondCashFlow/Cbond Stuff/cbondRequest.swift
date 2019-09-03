//
//  cbondRequest.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 02.09.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import Foundation

extension UpdateLocalDataSection {

    //  MARK: - TODO: add filters to query
    
    func cbondRequest(login: String = "igor@rbiz.group",
                      password: String = "bonmaM-wojhed-fokza3",
                      filters: String,
                      limit: Int = 10,
                      offset: Int = 0,
                      cbondOperation: String = "get_flow") throws -> URLRequest {
        
        //  could handle just "get_flow" (потоки платежей) or "get_emissions" (параметры эмиссий)
        //  they're called Operations
        //  other types not supported
        
        
        //  MARK: TODO: use hash to store password
        //  MARK: TODO: prevent dismiss by swipe with empty fields
        if !(cbondOperation == "get_flow" || cbondOperation == "get_emissions") {
            print("incorrect cbond operation")
            throw CBondError.incorrectOperation
        }
        
        let url = URL(string: "https://ws.cbonds.info/services/json/" + cbondOperation + "/")!
        var request = URLRequest(url: url)
        request.httpMethod = "Post"
        
        let json = "{\"auth\":{\"login\":\"\(login)\",\"password\":\"\(password)\"},\(filters)\"quantity\":{\"limit\":" + String(limit) + ",\"offset\":" + String(offset) + "}}"
        
        request.httpBody = json.data(using: .utf8)
        
        return request
    }

}

//
//  Position.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 01.09.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import Foundation

struct Position: Identifiable, Codable, Hashable {
    var id = UUID()
    
    var portfolioName: String = ""
    let emissionID: Int
    var qty: Int = 1
    
    init() {
        self.portfolioName = "Megatron"
        self.emissionID = 1
        self.qty = 1
    }
    
    init(portfolioName: String, emissionID: Int, qty: Int) {
        self.portfolioName = portfolioName
        self.emissionID = emissionID
        self.qty = qty
    }
}

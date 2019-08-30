//
//  CalCashFlow.swift
//  TestCombine
//
//  Created by Igor Malyarov on 29.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import Foundation

struct CalCashFlow {
    var date: Date
    var flows: [CalCashFlowItem]
}
extension CalCashFlow {
    var total: Int {
        flows.reduce(0, { $0 + $1.amount })
    }
}

struct CalCashFlowItem: Identifiable, Hashable {
    var id = UUID()
    
    var portfolioName: String
    var documentRus: String
    var amount: Int
    var flowType: CalendarCashFlowType
}

enum CalendarCashFlowType: String {
    case principal = "Номинал"
    case coupon = "Купон"
}

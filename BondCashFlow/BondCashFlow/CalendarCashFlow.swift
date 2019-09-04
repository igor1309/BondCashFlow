//
//  CalendarCashFlow.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 22.07.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct CalendarCashFlow: Identifiable, Codable, Hashable {
    var id = UUID()
    
    var date: Date
    var portfolioName: String
    var emitent: String
    var instrument: String
    var amount: Int
    var type: CashFlowType
}

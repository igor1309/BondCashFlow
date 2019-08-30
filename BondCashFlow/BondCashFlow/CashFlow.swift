//
//  CashFlow.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 22.07.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct CashFlow: Identifiable, Codable, Hashable {
    var id = UUID()
    
    var date: Date
    var amount: Double
    var instrument: String  //  код выпуска???
    var type: CashFlowType
}

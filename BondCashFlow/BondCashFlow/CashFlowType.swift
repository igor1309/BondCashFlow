//
//  CashFlowType.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 22.07.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI
import Combine

enum CashFlowType: String, CaseIterable, Codable, Hashable {
    case coupon = "Купон"
    case face = "Номинал"
    
    var id: String {
        return rawValue
    }
}

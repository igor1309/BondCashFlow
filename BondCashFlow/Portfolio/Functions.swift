//
//  Functions.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 09.09.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import Foundation

/// concatenate array of strings to one string with ", " as divider
func stringFromArray(_ array: [String]) -> String {
    let count = array.count
    
    if count == 0 { return "" }
    else if count == 1 { return array[0] }
    else {
        return String(array.reduce(""){ $0 + $1 + ", "}.dropLast(2))
    }
}

//
//  Int+RusGrammar+Extension.swift
//  BondsCashFlow
//
//  Created by Igor Malyarov on 28.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import Foundation

extension Int {
    var emaleEnding: String {
        let end = self % 10
        for i in 2...20 {
            return (i + end).formattedGrouped
        }
        return end.formattedGrouped
    }
}

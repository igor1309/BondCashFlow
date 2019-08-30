//
//  Extension+Array.swift
//  BondsCashFlow
//
//  Created by Igor Malyarov on 25.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import Foundation

//  https://www.hackingwithswift.com/example-code/language/how-to-remove-duplicate-items-from-an-array
//  That provides two methods: one called removingDuplicates() that returns an array with duplicates removed, and one called removeDuplicates() that changes the array in place.
public extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()
        
        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }
    
    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}

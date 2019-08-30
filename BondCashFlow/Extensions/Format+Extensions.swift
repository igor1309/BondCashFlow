//
//  Format+Extensions.swift
//
//  Created by Igor Malyarov on 31.07.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import Foundation

public extension Int {
    var formattedGrouped: String {
        return Formatter.groupedFormat.string(for: self) ?? ""
    }
}

public extension Double {
    var formattedPercentage: String {
        return Formatter.percentageFormat.string(for: self) ?? ""
    }
    
    var formattedPercentageWithDecimals: String {
        return Formatter.percentageWithDecimalsFormat.string(for: self) ?? ""
    }
    
    var formattedGrouped: String {
        return Formatter.groupedFormat.string(for: self) ?? ""
    }
    
    var formattedGroupedWithDecimals: String {
        return Formatter.groupedWithDecimalsFormat.string(for: self) ?? ""
    }
}

public extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

public extension Formatter {
    static let groupedFormat: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        return formatter
    }()
    
    static let groupedWithDecimalsFormat: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    static let percentageFormat: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        return formatter
    }()
    
    static let percentageWithDecimalsFormat: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
}

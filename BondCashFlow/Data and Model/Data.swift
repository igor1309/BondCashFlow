//
//  Data.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 22.07.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

let emissionMetadataData = loadCBondEmissionMetadata()

func loadCBondEmissionMetadata() -> CBondEmissionMetadata? {
    guard let data: CBondEmissionMetadata = loadFromDocDir("emissionMetadata.json") else {
        return nil
    }
    
    return data
}

let flowMetadataData = loadCBondFlowMetadata()

func loadCBondFlowMetadata() -> CBondFlowMetadata? {
    guard let data: CBondFlowMetadata = loadFromDocDir("flowMetadata.json") else {
        return nil
    }
    
    return data
}

let portfolioNamesData = loadPortfolioNamesData()

func loadPortfolioNamesData() -> [String] {
    guard let data: [String] = loadFromDocDir("portfolioNames.json") else {
        return ["Bumblebee", "Megatron"]
    }
    
    return data
}

let favoriteEmissionsData = loadFavoriteEmissionsData()

func loadFavoriteEmissionsData() -> [Int: Bool] {
    guard let data: [Int: Bool] = loadFromDocDir("favoriteEmissions.json") else {
        return [:]
    }
    
    return data
}
func loadFavoriteEmissionsDataOLD() -> [Int: Bool] {
    let decoder = JSONDecoder()
    let filenameURL = URL(fileURLWithPath: "favoriteEmissions",
                          relativeTo: FileManager.documentDirectoryURL)
        .appendingPathExtension("json")
    
    do {
        let data = try Data(contentsOf: filenameURL)
        return try decoder.decode([Int: Bool].self, from: data)
    }
    catch let error {
        print("Error: \(error.localizedDescription)")
        return [:]
    }
}

let positionData = loadPositionData()

let emissionData = loadEmissionData()

func loadEmissionData() -> [Emission] {
    guard let data: [Emission] = loadFromDocDir("emissions.json") else {
        return []
    }
    
    return data
}
func loadEmissionDataOLD() -> [Emission] {
    let decoder = JSONDecoder()
    let filenameURL = URL(fileURLWithPath: "emissions",
                          relativeTo: FileManager.documentDirectoryURL)
        .appendingPathExtension("json")
    
    do {
        let data = try Data(contentsOf: filenameURL)
        return try decoder.decode([Emission].self, from: data)
    }
    catch let error {
        print("Error: \(error.localizedDescription)")
        return []
    }
}

let cashFlowData = loadCashFlowData()

func loadCashFlowData() -> [Flow] {
    guard let data: [Flow] = loadFromDocDir("flow.json") else {
        return []
    }
    
    return data
}
func loadCashFlowDataOLD() -> [Flow] {
    let decoder = JSONDecoder()
    let filenameURL = URL(fileURLWithPath: "flow",
                          relativeTo: FileManager.documentDirectoryURL)
        .appendingPathExtension("json")
    
    do {
        let data = try Data(contentsOf: filenameURL)
        return try decoder.decode([Flow].self, from: data)
    }
    catch let error {
        print("Error: \(error.localizedDescription)")
        return []
    }
}

func loadPositionData() -> [Position] {
    guard let data: [Position] = loadFromDocDir("porfolios.json") else {
        return [
            Position(portfolioName: "Bumblebee", emissionID: 460, qty: 10),
            Position(portfolioName: "Bumblebee", emissionID: 2928, qty: 100),
            Position(portfolioName: "Bumblebee", emissionID: 5165, qty: 1),
            Position(portfolioName: "Megatron", emissionID: 5165, qty: 1000),
            Position(portfolioName: "Megatron", emissionID: 2717, qty: 100)
        ]
    }
    
    return data
}

let calendarCashFlowData = loadCalendarCashFlowData()

func loadCalendarCashFlowData() -> [CalendarCashFlow] {
    return [
        CalendarCashFlow(date: Date().firstDayOfWeekRU.addDays(0), amount: 100000, instrument: "Мастер", type: .coupon),
        CalendarCashFlow(date: Date().firstDayOfWeekRU.addDays(2), amount: 10000, instrument: "Ломбард", type: .face),
        CalendarCashFlow(date: Date().addWeeks(1).firstDayOfWeekRU.addDays(3), amount: 200000, instrument: "Ломбард", type: .coupon),
        CalendarCashFlow(date: Date().addWeeks(2).firstDayOfWeekRU.addDays(2), amount: 200000, instrument: "Мастер", type: .face),
        CalendarCashFlow(date: Date().addWeeks(2).firstDayOfWeekRU.addDays(3), amount: 100000, instrument: "Мастер", type: .coupon),
        CalendarCashFlow(date: Date().addWeeks(3).firstDayOfWeekRU.addDays(1), amount: 10000, instrument: "Ломбард", type: .face),
        CalendarCashFlow(date: Date().addWeeks(5).firstDayOfWeekRU.addDays(3), amount: 200000, instrument: "Ломбард", type: .coupon),
        CalendarCashFlow(date: Date().addWeeks(8).firstDayOfWeekRU.addDays(3), amount: 200000, instrument: "Ломбард", type: .face),
        CalendarCashFlow(date: Date().addWeeks(15).firstDayOfWeekRU.addDays(4), amount: 200000, instrument: "Мастер", type: .coupon),
        CalendarCashFlow(date: Date().addWeeks(19).firstDayOfWeekRU.addDays(0), amount: 200000, instrument: "Мастер", type: .coupon),
        CalendarCashFlow(date: Date().addWeeks(26).firstDayOfWeekRU.addDays(1), amount: 200000, instrument: "Ломбард", type: .coupon)
    ]
}

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
        return []
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

let positionData = loadPositionData()

func loadPositionData() -> [Position] {
    guard let data: [Position] = loadFromDocDir("positions.json") else {
        return []
    }
    
    return data
}

let emissionData = loadEmissionData()

func loadEmissionData() -> [Emission] {
    guard let data: [Emission] = loadFromDocDir("emissions.json") else {
        return []
    }
    
    return data
}

let cashFlowData = loadCashFlowData()

func loadCashFlowData() -> [Flow] {
    guard let data: [Flow] = loadFromDocDir("flows.json") else {
        return []
    }
    
    return data
}

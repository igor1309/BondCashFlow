//
//  UserData.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 22.07.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//
//  A model object that stores app data.


import Foundation

final class UserData: ObservableObject {
    private let defaults = UserDefaults.standard
    
    @Published var emissionMetadata: CBondEmissionMetadata? = emissionMetadataData {
        didSet {
            saveJSON(data: emissionMetadata, filename: "emissionMetadata.json")
        }
    }
    
    @Published var flowMetadata: CBondFlowMetadata? = flowMetadataData {
        didSet {
            saveJSON(data: flowMetadata, filename: "flowMetadata.json")
        }
    }
    
    @Published var emissions = emissionData {
        didSet {
            saveJSON(data: emissions, filename: "emissions.json")
        }
    }
    
    @Published var flows = cashFlowData {
        didSet {
            saveJSON(data: flows, filename: "flows.json")
        }
    }
    
    var emitents: [String] {
        emissions.map { $0.emitentNameRus }.removingDuplicates()
    }
    
    @Published var portfolioNames: [String] = portfolioNamesData {
        didSet {
            saveJSON(data: portfolioNames, filename: "portfolioNames.json")
        }
    }
    
    @Published var favoriteEmissions: [Int: Bool] = favoriteEmissionsData {
        didSet {
            saveJSON(data: favoriteEmissions, filename: "favoriteEmissions.json")
        }
    }
    
    @Published var positions: [Position] = positionData {
        didSet {
            saveJSON(data: positions, filename: "positions.json")
        }
    }
    
    var hasAtLeastTwoPortfolios: Bool {
        positions.map({ $0.portfolioName }).removingDuplicates().count > 1
    }
    
    @Published var cashFlows = calendarCashFlowData
    
    @Published var baseDate = Date()
    
}

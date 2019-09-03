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
    
    //  фильтры ломаются, поэтому всегда стартуем со всех портфелей
    @Published var isAllPortfoliosSelected: Bool = true || UserDefaults.standard.bool(forKey: "isAllPortfoliosSelected") {
        didSet {
            defaults.set(isAllPortfoliosSelected, forKey: "isAllPortfoliosSelected")
        }
    }
    
    @Published var selectedPortfolio: String = UserDefaults.standard.string(forKey: "selectedPortfolio") ?? "" {
        didSet {
            defaults.set(selectedPortfolio, forKey: "selectedPortfolio")
        }
    }
    
    @Published var lastCBondOperationUsed: String = UserDefaults.standard.string(forKey: "lastCBondOperationUsed") ?? "" {
        didSet {
            defaults.set(lastCBondOperationUsed, forKey: "lastCBondOperationUsed")
        }
    }
    
    @Published var lastCBondLimitUsed: Int = UserDefaults.standard.integer(forKey: "lastCBondLimitUsed") {
        didSet {
            defaults.set(lastCBondLimitUsed, forKey: "lastCBondLimitUsed")
        }
    }
    
    @Published var lastCBondOffsetUsed: Int = UserDefaults.standard.integer(forKey: "lastCBondOffsetUsed") {
        didSet {
            defaults.set(lastCBondOffsetUsed, forKey: "lastCBondOffsetUsed")
        }
    }
    
    @Published var cashFlows = calendarCashFlowData
    
    @Published var baseDate = Date()
    
    //  MARK: TODO: use hash to store password
    @Published var login: String = UserDefaults.standard.string(forKey: "login") ?? "test" {
        didSet {
            defaults.set(login, forKey: "login")
        }
    }
    
    @Published var password: String = UserDefaults.standard.string(forKey: "password") ?? "test" {
        didSet {
            defaults.set(password, forKey: "password")
        }
    }
    
    @Published var lastTabUsed: Int = UserDefaults.standard.integer(forKey: "lastTabUsed") {
        didSet {
            defaults.set(lastTabUsed, forKey: "lastTabUsed")
        }
    }
}

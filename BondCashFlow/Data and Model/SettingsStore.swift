//
//  SettingsStore.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 04.09.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import Foundation

final class SettingsStore: ObservableObject {
    private let defaults = UserDefaults.standard
    
    @Published var lastTabUsed: Int = UserDefaults.standard.integer(forKey: "lastTabUsed") {
        didSet {
            defaults.set(lastTabUsed, forKey: "lastTabUsed")
        }
    }
    
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
}
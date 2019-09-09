//
//  SettingsStore.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 04.09.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import Foundation

final class SettingsStore: ObservableObject {

    @Published var weeksToShowInCalendar = 52
    
    @Published var startDate = Date().firstDayOfWeekRU.startOfDay // DateComponents(calendar: .current, year: 2019, month: 11, day: 25).date!//Date()//DateComponents(calendar: .current, year: 2011, month: 08, day: 11).date!
    
    //  для тестирования потоков
    @Published var isFutureFlowsOnly: Bool = true || UserDefaults.standard.bool(forKey: "isFutureFlowsOnly") {
        didSet {
            defaults.set(isFutureFlowsOnly, forKey: "isFutureFlowsOnly")
        }
    }
    
func reset() {
//        lastTabUsed = 2
        login = "test"
        password = "test"
        isAllPortfoliosSelected = true
        selectedPortfolio = ""
        lastCBondOperationUsed = "get_emissions"
        lastCBondLimitUsed = 1000
        lastCBondOffsetUsed = 0
        weeksToShowInCalendar = 52
        startDate = Date().firstDayOfWeekRU.startOfDay
    }
    
    func loginTest() {
        login = "test"
        password = "test"
    }
    
    func loginIgor() {
        login = "igor@rbiz.group"
        password = "bonmaM-wojhed-fokza3"
    }
    
    var isTestLogin: Bool {
        login == "test" && password == "test"
    }
    
    var isIgorLogin: Bool {
        login == "igor@rbiz.group" && password == "bonmaM-wojhed-fokza3"
    }
    
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
    
    @Published var selectedPortfolioView: String = UserDefaults.standard.string(forKey: "selectedPortfolioView") ?? "" {
        didSet {
            defaults.set(selectedPortfolioView, forKey: "selectedPortfolioView")
        }
    }
    
    @Published var selectedPortfolioID: UUID = UUID(uuidString: UserDefaults.standard.string(forKey: "selectedPortfolioID") ?? "9009E038-AF68-4E55-A15E-F6C5059B79BD") {
        didSet {
            defaults.set(selectedPortfolioID, forKey: "selectedPortfolioID")
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

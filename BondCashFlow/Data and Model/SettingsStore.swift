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
    
    @Published var weeksToShowInCalendar = 52
    
    @Published var startDate = Date().firstDayOfWeekRU.startOfDay // DateComponents(calendar: .current, year: 2019, month: 11, day: 25).date!//Date()//DateComponents(calendar: .current, year: 2011, month: 08, day: 11).date!
    
    @Published var isLocalStoreShowMore: Bool = true || UserDefaults.standard.bool(forKey: "isLocalStoreShowMore") {
        didSet {
            defaults.set(isLocalStoreShowMore, forKey: "isLocalStoreShowMore")
        }
    }
    
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

extension SettingsStore {
    var isTestLogin: Bool {
        login == "test" && password == "test"
    }
    
    var isIgorLogin: Bool {
        login == "igor@rbiz.group" && password == "bonmaM-wojhed-fokza3"
    }
}

extension SettingsStore {
    func reset() {
        //        lastTabUsed = 2
        login = "test"
        password = "test"
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
}

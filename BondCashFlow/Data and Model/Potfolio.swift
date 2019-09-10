//
//  Potfolio.swift
//  BondsCashFlow
//
//  Created by Igor Malyarov on 26.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import Foundation

struct Portfolio: Identifiable, Codable, Hashable {
    var id = UUID()
    
    var name: String
    var broker: String
    var note: String
    
    init() {
        self.name = ""//Новый портфель"
        self.broker = ""//"Какой-то брокер"
        self.note = ""//"Комментарий"
    }
    init(name: String, broker: String, comment: String) {
        self.name = name
        self.broker = broker
        self.note = comment
    }
}

extension Portfolio {
    
    //  MARK: TODO
    var value: Int { 0 }
    var faceValue: Int { 1_000_000 }
    var nearestFlow: Int { 100_000 }
    var nearestFlowDate: Date { Date().addWeeks(6) }
    var emissionsList: String { "List of Emission to be done soon (TBD)" }
}

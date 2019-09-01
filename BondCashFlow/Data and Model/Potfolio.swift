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
    var positions: [Position]
    
    init() {
        self.name = "Portfolio"
        self.positions = []
    }
    
    init(name: String, positions: [Position]) {
        self.name = name
        self.positions = positions
    }
}

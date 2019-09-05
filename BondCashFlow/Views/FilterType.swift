//
//  FilterType.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 05.09.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

enum FilterType: String, CaseIterable {
    case all = "все эмиссии"
    case withFlows = "только эмиссии с потоками"
    case withFutureFlows = "эмиссии с будущими потоками" // начиная от SettingsStore.startDate
    case favorites = "★ избранные"
    //  MARK: TODO додумать и доделать
    case emitent = "фильтр по эмитенту"
    case byText = "текстовый фильтр"
}

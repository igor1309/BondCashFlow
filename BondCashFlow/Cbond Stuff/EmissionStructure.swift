//
//  EmissionStructure.swift
//  BondsCashFlow
//
//  Created by Igor Malyarov on 25.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct EmissionStructure: Codable, Hashable {
    let id: Int // Уникальный идентификатор long
    let isinCode: String // Код ISIN Varchar
    let emitentNameRus: String // Эмитент (rus) Varchar
    let maturityDate: Date // Дата погашения Date
    let cupon_rus: String // Ставка купона (rus) Varchar
    let cupon_period: Int // Периодичность выплаты купона Int
    let emitentID: Int // Эмитент long | совпадает с emissionEmitentID
    let emissionEmitentID: Int // Эмитент (id) long | совпадает с emitentID
    let emitentFullNameRus: String // Полное название эмитента (rus) Varchar
    let documentRus: String // Название эмиссии (rus) Varchar
    
    init(from: CBondEmission) {
        self.id = Int(from.id) ?? -1
        self.isinCode = from.isinCode
        self.emitentNameRus = from.emitentNameRus
        
        //  date @ get_emissions is optional string like 2011-03-28
        if from.maturityDate != nil {
            let dateComponents = DateComponents(year: Int(from.maturityDate!.prefix(4)),
                                                month: Int(from.maturityDate!.suffix(5).prefix(2)),
                                                day: Int(from.maturityDate!.suffix(2)))
            self.maturityDate = Calendar.current.date(from: dateComponents) ?? .distantPast
        } else {
            self.maturityDate = .distantPast
        }
        self.cupon_rus = from.cuponRus
        self.cupon_period = Int(from.cuponPeriod ?? "") ?? 0
        self.emitentID = Int(from.emitentID ?? "-1") ?? -1
        self.emissionEmitentID = Int(from.emissionEmitentID ?? "-1") ?? -1
        self.emitentFullNameRus = from.emitentFullNameRus ?? ""
        self.documentRus = from.documentRus ?? ""
    }
    
    init() {
        self.id = 987987
        self.isinCode = "111222XXXJJJ888"
        self.emitentNameRus = "Тестовый эмитент"
        self.maturityDate = Date().addWeeks(10)
        self.cupon_rus = "Ставка купона"
        self.cupon_period = 90
        self.emitentID = 54321
        self.emissionEmitentID = 54321
        self.emitentFullNameRus = "Полное название тестового эмитента"
        self.documentRus = "ЭЭ-01АА"
    }
}

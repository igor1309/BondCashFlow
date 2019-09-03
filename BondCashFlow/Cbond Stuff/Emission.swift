//
//  Emission.swift
//  BondsCashFlow
//
//  Created by Igor Malyarov on 25.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct Emission: Codable, Hashable {
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
    
    init(from cbond: CBondEmission) {
        self.id = Int(cbond.id) ?? -1
        self.isinCode = cbond.isinCode
        self.emitentNameRus = cbond.emitentNameRus
        
        //  date @ get_emissions is optional string like 2011-03-28
        if cbond.maturityDate != nil {
            let dateComponents = DateComponents(year: Int(cbond.maturityDate!.prefix(4)),
                                                month: Int(cbond.maturityDate!.suffix(5).prefix(2)),
                                                day: Int(cbond.maturityDate!.suffix(2)))
            self.maturityDate = Calendar.current.date(from: dateComponents) ?? .distantPast
        } else {
            self.maturityDate = .distantPast
        }
        self.cupon_rus = cbond.cuponRus
        self.cupon_period = Int(cbond.cuponPeriod ?? "") ?? 0
        self.emitentID = Int(cbond.emitentID ?? "-1") ?? -1
        self.emissionEmitentID = Int(cbond.emissionEmitentID ?? "-1") ?? -1
        self.emitentFullNameRus = cbond.emitentFullNameRus ?? ""
        self.documentRus = cbond.documentRus ?? ""
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

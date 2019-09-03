//
//  Flow.swift
//  BondsCashFlow
//
//  Created by Igor Malyarov on 25.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import Foundation

struct Flow: Codable, Hashable {
    /// Основные поля: Денежный поток - get_flow
    let id: Int // Уникальный идентификатор long
    let emissionID: Int // Эмиссия (id) long
    let emissionIsinCode: String // Код ISIN эмиссии Varchar
    let emissionEmitentID: Int //Эмитент (id) long
    let date: Date // Дата выплаты Date
    let startDate: Date // Дата начала купонного периода Date
    let couponNum: Int // Номер купона по порядку Int
    let cuponRate: Double // Ставка купона, % годовых Double
    let cuponRateDate: Date //Дата, когда стал известен купон Date
    let cuponSum: Double // Сумма купона Double
    let daysBeetwenCoupons: Int // Дней между купонами Int
    let redemtion: Double // Погашение номинала Double
    let updatingDate: Date // Дата создания или последнего обновления записи Date
    //    let actualPaymentDate: String // Фактическая дата выплаты Date
    //    let cuponSumEurobondsNominal: Double // Сумма купона (от номинала для еврооблигаций) Double
    //    let cuponSumIntegralMultiple: Double // Сумма купона (от лота кратности) Double
    //    let nontradingStartDate: String // Date // Начало периода приостановки торгов Date
    //    let nontradingStopDate: String // Date // Конец периода приостановки торгов Date
    //    let redemptionEurobondsNominal: Double // Погашение (от номинала для еврооблигаций) Double
    //    let redemptionIntegralMultiple: Double // Погашение (от лота кратности) Double
    
    init(from cbond: CBondFlow) {
        self.id = Int(cbond.id) ?? -1
        self.emissionID = Int(cbond.emissionID ?? "-1") ?? -1
        self.emissionIsinCode = cbond.emissionIsinCode ?? ""
        self.emissionEmitentID = Int(cbond.emissionEmitentID  ?? "-1") ?? -1
        
        //  date @ get_flow is string like 2011-03-28
        if let date = cbond.date {
            let dateComponents = DateComponents(year: Int(date.prefix(4)),
                                                month: Int(date.suffix(5).prefix(2)),
                                                day: Int(date.suffix(2)))
            self.date = Calendar.current.date(from: dateComponents) ?? .distantPast
        } else {
            self.date = .distantPast
        }
        
        self.startDate = cbond.startDate ?? .distantPast
        self.couponNum = Int(cbond.couponNum ?? "-1") ?? -1
        self.cuponRate = Double(cbond.cuponRate ?? "-1") ?? -1
        self.cuponRateDate = cbond.cuponRateDate ?? .distantPast
        self.cuponSum = Double(cbond.cuponSum ?? "-1") ?? -1
        self.daysBeetwenCoupons = Int(cbond.daysBeetwenCoupons ?? "-1") ?? -1
        self.redemtion = Double(cbond.redemtion ?? "-1") ?? -1
        self.updatingDate = cbond.updatingDate ?? .distantPast
        //        self.actualPaymentDate = cbond.actualPaymentDate ?? ""
        //        self.cuponSumEurobondsNominal = Double(cbond.cuponSumEurobondsNominal) ?? -1
        //        self.cuponSumIntegralMultiple = Double(cbond.cuponSumIntegralMultiple) ?? -1
        //        self.nontradingStartDate = cbond.nontradingStartDate ?? ""
        //        self.nontradingStopDate = cbond.nontradingStopDate ?? ""
        //        self.redemptionEurobondsNominal = Double(cbond.redemptionEurobondsNominal ?? "") ?? -1
        //        self.redemptionIntegralMultiple = Double(cbond.redemptionIntegralMultiple ?? "") ?? -1
    }
    
    init() {
        self.id = 676832
        self.emissionID = 987987
        self.emissionIsinCode = "111222XXXJJJ888"
        self.emissionEmitentID = 54321
        self.date = Date().addWeeks(5)
        self.startDate = Date().addWeeks(1)
        self.couponNum = 11
        self.cuponRate = 0.111
        self.cuponRateDate = Date().addWeeks(3)
        self.cuponSum = 12678
        self.daysBeetwenCoupons = 90
        self.redemtion = 33333
        self.updatingDate = Date()
    }
}

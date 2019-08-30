//
//  CBondFlow.swift
//  BondsCashFlow
//
//  Created by Igor Malyarov on 25.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import Foundation

// MARK: - CBondGetFlow
public struct CBondGetFlow: Codable {
    let count, total, limit, offset: Int
    let execTime: Double
    public let items: [CBondFlow]
    let meta: Meta
    
    enum CodingKeys: String, CodingKey {
        case count, total, limit, offset
        case execTime = "exec_time"
        case items, meta
    }
}

// MARK: - CBondFlow
public struct CBondFlow: Codable {
    public let id: String
    public let emissionIsinCode: String?
    public let emissionID, emissionEmitentID, couponNum, cuponRate, cuponSum: String?
    public let date: String?
    public let cuponRateDate: Date?
    public let updatingDate: Date?
    public let startDate: Date?
    public let emissionKindID, emissionNominalPrice: String?
    public let actualPaymentDate: String? //Date?
    public let cuponSumEurobondsNominal, cuponSumIntegralMultiple: String?
    public let daysBeetwenCoupons: String? //Int?
    public let emissionEmitentCountryID, emissionEmitentCountryRegionID: String?
    public let emissionEmitentCountrySubregionID: String?
    public let moreRus, moreEng: String?
    public let nontradingStartDate, nontradingStopDate, recordDate: String?
    public let redemtion, redemptionIntegralMultiple, redemptionEurobondsNominal, emissionIntegralMultiple: String?
    public let showEm, showRu, showUa: String?
    public let moreIta, morePol, poolFactor: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case actualPaymentDate = "actual_payment_date"
        case couponNum = "coupon_num"
        case cuponRate = "cupon_rate"
        case cuponRateDate = "cupon_rate_date"
        case cuponSum = "cupon_sum"
        case cuponSumEurobondsNominal = "cupon_sum_eurobonds_nominal"
        case cuponSumIntegralMultiple = "cupon_sum_integral_multiple"
        case date
        case daysBeetwenCoupons = "days_beetwen_coupons"
        case emissionEmitentCountryID = "emission_emitent_country_id"
        case emissionEmitentCountryRegionID = "emission_emitent_country_region_id"
        case emissionEmitentCountrySubregionID = "emission_emitent_country_subregion_id"
        case emissionEmitentID = "emission_emitent_id"
        case emissionID = "emission_id"
        case emissionIntegralMultiple = "emission_integral_multiple"
        case emissionIsinCode = "emission_isin_code"
        case emissionKindID = "emission_kind_id"
        case emissionNominalPrice = "emission_nominal_price"
        case moreEng = "more_eng"
        case moreIta = "more_ita"
        case morePol = "more_pol"
        case moreRus = "more_rus"
        case nontradingStartDate = "nontrading_start_date"
        case nontradingStopDate = "nontrading_stop_date"
        case recordDate = "record_date"
        case redemptionEurobondsNominal = "redemption_eurobonds_nominal"
        case redemptionIntegralMultiple = "redemption_integral_multiple"
        case redemtion
        case showEm = "show_em"
        case showRu = "show_ru"
        case showUa = "show_ua"
        case startDate = "start_date"
        case updatingDate = "updating_date"
        case poolFactor = "pool_factor"
    }
}

//
//  CBondEmission.swift
//  BondsCashFlow
//
//  Created by Igor Malyarov on 25.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import Foundation

// MARK: - CBondGetEmission
public struct CBondGetEmission: Codable {
    let count, total, limit, offset: Int
    let execTime: Double
    public let items: [CBondEmission]
    let meta: Meta
    
    enum CodingKeys: String, CodingKey {
        case count, total, limit, offset
        case execTime = "exec_time"
        case items, meta
    }
}

// MARK: - CBondEmission
public struct CBondEmission: Codable {
    public let id: String
    public let isinCode, emitentNameRus, cuponRus: String
    public let formalEmitentID, formalEmitentCountry, formalEmitentBranchID, formalEmitentRegFormID, formalEmitentType, formalEmitentNameEng, formalEmitentNameRus: String?
    public let formalEmitentNamePol, formalEmitentNameIta: String?
    public let announcedVolume: String?
    public let auctionTypeID: String?
    public let bbgid, bbgidComposite: String?
    public let bbgidTicker: String?
    public let bondType, cfiCode, cfiCode144A, convertable: String?
    public let couponTypeID, updatingDate: String?
    public let cusip144A, cusipRegs, cuponPeriod: String?
    public let currencyID, currencyName: String?
    public let dateOfEndPlacing: String?
    public let dateOfStartCirculation, dateOfStartPlacing: String?
    public let dccCode, dccCode144A, documentEng, documentRus: String?
    public let documentPol, documentIta: String?
    public let earlyRedemptionDate: String?
    public let emissionCuponBasisID, emissionCuponBasisTitle, emissionEmitentID, emitentID: String?
    public let floatingRate: String?
    public let isinCode144A, isinCode3: String?
    public let incomeOfPrimaryPlacing, issueFormID, integralMultiple: String?
    public let kindID: String?
    public let maturityDate, margin: String?
    public let micexShortname: String?
    public let nextReplacingAmount, nextReplacingDate: String?
    public let nominalPrice, numberOfEmission, numberOfEmissionEng, outstandingNominalPrice: String?
    public let placedVolume: String?
    public let placingTypeID: String?
    public let priceOfPrimaryPlacing: String?
    public let privateOfferingID: String?
    public let referenceRateID, registrationDate: String?
    public let settlementDate: String?
    public let ssTgCountries, ssTgQlists, ssTradingGrounds: String?
    public let stateRegNumber, statusID, subordinatedDebt: String?
    public let subkindID: String?
    public let vidID, agentsEng, agentsRus: String?
    public let agentsPol, agentsIta: String?
    public let cuponEng: String?
    public let cuponPol, cuponIta: String?
    public let indexationEng, indexationRus: String?
    public let indexationPol, indexationIta: String?
    public let numberOfEmissionRus, numberOfEmissionPol, numberOfEmissionIta: String?
    public let kindNameEng, kindNameRus, kindNamePol, kindNameIta: String?
    public let placingTypeNameEng, placingTypeNameRus, placingTypeNamePol, placingTypeNameIta: String?
    public let statusNameEng, statusNameRus, statusNamePol, statusNameIta: String?
    public let emitentCountry, emitentCountryRegionID, emitentCountrySubregionID, emitentEmail: String?
    public let emitentInn, emitentInnUa, emitentPhone, emitentRegFormID: String?
    public let emitentRegFormNameEng, emitentRegFormNameRus, emitentType, emitentBranchID: String?
    public let emitentCountryNameEng, emitentCountryNameRus, emitentCountryNamePol, emitentCountryNameIta: String?
    public let emitentAdressEng, emitentAdressRus: String?
    public let emitentAdressPol, emitentAdressIta: String?
    public let emitentNameEng, emitentNamePol, emitentNameIta: String?
    public let emitentSiteEng, emitentSiteRus: String?
    public let emitentSitePol, emitentSiteIta: String?
    public let emitentTypeNameEng, emitentTypeNameRus, emitentTypeNamePol, emitentTypeNameIta: String?
    public let emitentBranchNameEng, emitentBranchNameRus, emitentBranchNamePol, emitentBranchNameIta: String?
    public let offertDate: String?
    public let updateTime: String?
    public let bookClosingDate, bookOpeningDate: String?
    public let moreEng, moreRus, mortgageBonds, restructing: String?
    public let restructingDate: String?
    public let restructingMoreEng, restructingMoreRus, emitentFullNameEng, emitentFullNameRus: String?
    public let emitentFullNamePol, emitentFullNameIta: String?
    public let perpetual: String?
    public let remainingOutstandAmount, cbrfListingLombardLastDateDate, govProgramStateRegNumber: String?
    public let privateIssue, securedDebt: String?
    public let spreadMidSwaps, spreadUsTreasures: String?
    public let eurobondsNominal: String?
    public let currCouponRate, currCouponSum: String?
    public let referenceRateNameEng, referenceRateNameRus, referenceRateNamePol, referenceRateNameIta: String?
    public let subkindNameEng, subkindNameRus, subkindNamePol, subkindNameIta: String?
    public let structuredNote, couponTypeNameEng, couponTypeNameRus: String?
    public let couponTypeNamePol, couponTypeNameIta, vidNameEng, vidNameRus: String?
    public let vidNamePol, vidNameIta: String?
    public let issueFormNameEng, issueFormNameRus: String?
    public let issueFormNamePol, issueFormNameIta: String?
    public let privateOfferingNameEng, privateOfferingNameRus, privateOfferingNamePol, privateOfferingNameIta: String?
    public let auctionTypeNameEng, auctionTypeNameRus: String?
    public let auctionTypeNamePol, auctionTypeNameIta, govProgramRegistrationDate: String?
    public let emissionWknCode: String?
    public let initialPlacementVolume, emissionCouponRate, settlementDuration: String?
    public let emissionWknCode144A: String?
    public let usdVolume: String?
    public let offertRus, offertEng: String?
    public let offertPol, offertIta, offertDatePut, offertDateCall: String?
    public let convertCondRus, convertCondEng: String?
    public let convertCondPol, convertCondIta, tradingGroundNameRus, tradingGroundNameEng: String?
    public let tradingGroundNamePol: String?
    public let tradingGroundNameIta, tradingGroundsFullRus, tradingGroundsFullEng, tradingsMaxdate: String?
    public let tradingsIndicativePrice, tradingsYieldEffect, tradingsDuration: String?
    public let emissionCbrCode, securitisation: String?
    public let floor, cup: String?
    public let serialOfEmission, serialOfEmissionEng: String?
    public let sedol: String?
    public let spCategoryID, spCategoryNameEng, spTypeID, spTypeNameEng: String?
    public let underlyingClassID, underlyingClassNameEng, guarantorNameEng, guarantorID: String?
    public let bondClass, delayDays: String?
    public let bondRank, bondRankNameRus, bondRankNameEng, bondIssueForm: String?
    public let bondIssueFormNameRus, bondIssueFormNameEng, statusIssueForm, statusIssueFormNameRus: String?
    public let statusIssueFormNameEng: String?
    public let qgcRewriteType: String?
    public let allBondTypes: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case formalEmitentID = "formal_emitent_id"
        case formalEmitentCountry = "formal_emitent_country"
        case formalEmitentBranchID = "formal_emitent_branch_id"
        case formalEmitentRegFormID = "formal_emitent_reg_form_id"
        case formalEmitentType = "formal_emitent_type"
        case formalEmitentNameEng = "formal_emitent_name_eng"
        case formalEmitentNameRus = "formal_emitent_name_rus"
        case formalEmitentNamePol = "formal_emitent_name_pol"
        case formalEmitentNameIta = "formal_emitent_name_ita"
        case announcedVolume = "announced_volume"
        case auctionTypeID = "auction_type_id"
        case bbgid
        case bbgidComposite = "bbgid_composite"
        case bbgidTicker = "bbgid_ticker"
        case bondType = "bond_type"
        case cfiCode = "cfi_code"
        case cfiCode144A = "cfi_code_144a"
        case convertable
        case couponTypeID = "coupon_type_id"
        case updatingDate = "updating_date"
        case cuponPeriod = "cupon_period"
        case currencyID = "currency_id"
        case currencyName = "currency_name"
        case cusip144A = "cusip_144a"
        case cusipRegs = "cusip_regs"
        case dateOfEndPlacing = "date_of_end_placing"
        case dateOfStartCirculation = "date_of_start_circulation"
        case dateOfStartPlacing = "date_of_start_placing"
        case dccCode = "dcc_code"
        case dccCode144A = "dcc_code_144a"
        case documentEng = "document_eng"
        case documentRus = "document_rus"
        case documentPol = "document_pol"
        case documentIta = "document_ita"
        case earlyRedemptionDate = "early_redemption_date"
        case emissionCuponBasisID = "emission_cupon_basis_id"
        case emissionCuponBasisTitle = "emission_cupon_basis_title"
        case emissionEmitentID = "emission_emitent_id"
        case emitentID = "emitent_id"
        case floatingRate = "floating_rate"
        case incomeOfPrimaryPlacing = "income_of_primary_placing"
        case integralMultiple = "integral_multiple"
        case isinCode = "isin_code"
        case isinCode144A = "isin_code_144a"
        case isinCode3 = "isin_code_3"
        case issueFormID = "issue_form_id"
        case kindID = "kind_id"
        case margin
        case maturityDate = "maturity_date"
        case micexShortname = "micex_shortname"
        case nextReplacingAmount = "next_replacing_amount"
        case nextReplacingDate = "next_replacing_date"
        case nominalPrice = "nominal_price"
        case numberOfEmission = "number_of_emission"
        case numberOfEmissionEng = "number_of_emission_eng"
        case outstandingNominalPrice = "outstanding_nominal_price"
        case placedVolume = "placed_volume"
        case placingTypeID = "placing_type_id"
        case priceOfPrimaryPlacing = "price_of_primary_placing"
        case privateOfferingID = "private_offering_id"
        case referenceRateID = "reference_rate_id"
        case registrationDate = "registration_date"
        case settlementDate = "settlement_date"
        case ssTgCountries = "ss_tg_countries"
        case ssTgQlists = "ss_tg_qlists"
        case ssTradingGrounds = "ss_trading_grounds"
        case stateRegNumber = "state_reg_number"
        case statusID = "status_id"
        case subkindID = "subkind_id"
        case subordinatedDebt = "subordinated_debt"
        case vidID = "vid_id"
        case agentsEng = "agents_eng"
        case agentsRus = "agents_rus"
        case agentsPol = "agents_pol"
        case agentsIta = "agents_ita"
        case cuponEng = "cupon_eng"
        case cuponRus = "cupon_rus"
        case cuponPol = "cupon_pol"
        case cuponIta = "cupon_ita"
        case indexationEng = "indexation_eng"
        case indexationRus = "indexation_rus"
        case indexationPol = "indexation_pol"
        case indexationIta = "indexation_ita"
        case numberOfEmissionRus = "number_of_emission_rus"
        case numberOfEmissionPol = "number_of_emission_pol"
        case numberOfEmissionIta = "number_of_emission_ita"
        case kindNameEng = "kind_name_eng"
        case kindNameRus = "kind_name_rus"
        case kindNamePol = "kind_name_pol"
        case kindNameIta = "kind_name_ita"
        case placingTypeNameEng = "placing_type_name_eng"
        case placingTypeNameRus = "placing_type_name_rus"
        case placingTypeNamePol = "placing_type_name_pol"
        case placingTypeNameIta = "placing_type_name_ita"
        case statusNameEng = "status_name_eng"
        case statusNameRus = "status_name_rus"
        case statusNamePol = "status_name_pol"
        case statusNameIta = "status_name_ita"
        case emitentCountry = "emitent_country"
        case emitentCountryRegionID = "emitent_country_region_id"
        case emitentCountrySubregionID = "emitent_country_subregion_id"
        case emitentEmail = "emitent_email"
        case emitentInn = "emitent_inn"
        case emitentInnUa = "emitent_inn_ua"
        case emitentPhone = "emitent_phone"
        case emitentRegFormID = "emitent_reg_form_id"
        case emitentRegFormNameEng = "emitent_reg_form_name_eng"
        case emitentRegFormNameRus = "emitent_reg_form_name_rus"
        case emitentType = "emitent_type"
        case emitentBranchID = "emitent_branch_id"
        case emitentCountryNameEng = "emitent_country_name_eng"
        case emitentCountryNameRus = "emitent_country_name_rus"
        case emitentCountryNamePol = "emitent_country_name_pol"
        case emitentCountryNameIta = "emitent_country_name_ita"
        case emitentAdressEng = "emitent_adress_eng"
        case emitentAdressRus = "emitent_adress_rus"
        case emitentAdressPol = "emitent_adress_pol"
        case emitentAdressIta = "emitent_adress_ita"
        case emitentNameEng = "emitent_name_eng"
        case emitentNameRus = "emitent_name_rus"
        case emitentNamePol = "emitent_name_pol"
        case emitentNameIta = "emitent_name_ita"
        case emitentSiteEng = "emitent_site_eng"
        case emitentSiteRus = "emitent_site_rus"
        case emitentSitePol = "emitent_site_pol"
        case emitentSiteIta = "emitent_site_ita"
        case emitentTypeNameEng = "emitent_type_name_eng"
        case emitentTypeNameRus = "emitent_type_name_rus"
        case emitentTypeNamePol = "emitent_type_name_pol"
        case emitentTypeNameIta = "emitent_type_name_ita"
        case emitentBranchNameEng = "emitent_branch_name_eng"
        case emitentBranchNameRus = "emitent_branch_name_rus"
        case emitentBranchNamePol = "emitent_branch_name_pol"
        case emitentBranchNameIta = "emitent_branch_name_ita"
        case offertDate = "offert_date"
        case updateTime = "update_time"
        case bookClosingDate = "book_closing_date"
        case bookOpeningDate = "book_opening_date"
        case moreEng = "more_eng"
        case moreRus = "more_rus"
        case mortgageBonds = "mortgage_bonds"
        case restructing
        case restructingDate = "restructing_date"
        case restructingMoreEng = "restructing_more_eng"
        case restructingMoreRus = "restructing_more_rus"
        case emitentFullNameEng = "emitent_full_name_eng"
        case emitentFullNameRus = "emitent_full_name_rus"
        case emitentFullNamePol = "emitent_full_name_pol"
        case emitentFullNameIta = "emitent_full_name_ita"
        case perpetual
        case remainingOutstandAmount = "remaining_outstand_amount"
        case cbrfListingLombardLastDateDate = "cbrf_listing_lombard_last_date_date"
        case govProgramStateRegNumber = "gov_program_state_reg_number"
        case privateIssue = "private_issue"
        case securedDebt = "secured_debt"
        case spreadMidSwaps = "spread_mid_swaps"
        case spreadUsTreasures = "spread_us_treasures"
        case eurobondsNominal = "eurobonds_nominal"
        case currCouponRate = "curr_coupon_rate"
        case currCouponSum = "curr_coupon_sum"
        case referenceRateNameEng = "reference_rate_name_eng"
        case referenceRateNameRus = "reference_rate_name_rus"
        case referenceRateNamePol = "reference_rate_name_pol"
        case referenceRateNameIta = "reference_rate_name_ita"
        case subkindNameEng = "subkind_name_eng"
        case subkindNameRus = "subkind_name_rus"
        case subkindNamePol = "subkind_name_pol"
        case subkindNameIta = "subkind_name_ita"
        case structuredNote = "structured_note"
        case couponTypeNameEng = "coupon_type_name_eng"
        case couponTypeNameRus = "coupon_type_name_rus"
        case couponTypeNamePol = "coupon_type_name_pol"
        case couponTypeNameIta = "coupon_type_name_ita"
        case vidNameEng = "vid_name_eng"
        case vidNameRus = "vid_name_rus"
        case vidNamePol = "vid_name_pol"
        case vidNameIta = "vid_name_ita"
        case issueFormNameEng = "issue_form_name_eng"
        case issueFormNameRus = "issue_form_name_rus"
        case issueFormNamePol = "issue_form_name_pol"
        case issueFormNameIta = "issue_form_name_ita"
        case privateOfferingNameEng = "private_offering_name_eng"
        case privateOfferingNameRus = "private_offering_name_rus"
        case privateOfferingNamePol = "private_offering_name_pol"
        case privateOfferingNameIta = "private_offering_name_ita"
        case auctionTypeNameEng = "auction_type_name_eng"
        case auctionTypeNameRus = "auction_type_name_rus"
        case auctionTypeNamePol = "auction_type_name_pol"
        case auctionTypeNameIta = "auction_type_name_ita"
        case emissionWknCode = "emission_wkn_code"
        case govProgramRegistrationDate = "gov_program_registration_date"
        case initialPlacementVolume = "initial_placement_volume"
        case emissionCouponRate = "emission_coupon_rate"
        case settlementDuration = "settlement_duration"
        case emissionWknCode144A = "emission_wkn_code_144a"
        case usdVolume = "usd_volume"
        case offertRus = "offert_rus"
        case offertEng = "offert_eng"
        case offertPol = "offert_pol"
        case offertIta = "offert_ita"
        case offertDatePut = "offert_date_put"
        case offertDateCall = "offert_date_call"
        case convertCondRus = "convert_cond_rus"
        case convertCondEng = "convert_cond_eng"
        case convertCondPol = "convert_cond_pol"
        case convertCondIta = "convert_cond_ita"
        case tradingGroundNameRus = "trading_ground_name_rus"
        case tradingGroundNameEng = "trading_ground_name_eng"
        case tradingGroundNamePol = "trading_ground_name_pol"
        case tradingGroundNameIta = "trading_ground_name_ita"
        case tradingGroundsFullRus = "trading_grounds_full_rus"
        case tradingGroundsFullEng = "trading_grounds_full_eng"
        case tradingsMaxdate = "tradings_maxdate"
        case tradingsIndicativePrice = "tradings_indicative_price"
        case tradingsYieldEffect = "tradings_yield_effect"
        case tradingsDuration = "tradings_duration"
        case emissionCbrCode = "emission_cbr_code"
        case securitisation, floor, cup
        case serialOfEmission = "serial_of_emission"
        case serialOfEmissionEng = "serial_of_emission_eng"
        case sedol
        case spCategoryID = "sp_category_id"
        case spCategoryNameEng = "sp_category_name_eng"
        case spTypeID = "sp_type_id"
        case spTypeNameEng = "sp_type_name_eng"
        case underlyingClassID = "underlying_class_id"
        case underlyingClassNameEng = "underlying_class_name_eng"
        case guarantorNameEng = "guarantor_name_eng"
        case guarantorID = "guarantor_id"
        case bondClass = "bond_class"
        case delayDays = "delay_days"
        case bondRank = "bond_rank"
        case bondRankNameRus = "bond_rank_name_rus"
        case bondRankNameEng = "bond_rank_name_eng"
        case bondIssueForm = "bond_issue_form"
        case bondIssueFormNameRus = "bond_issue_form_name_rus"
        case bondIssueFormNameEng = "bond_issue_form_name_eng"
        case statusIssueForm = "status_issue_form"
        case statusIssueFormNameRus = "status_issue_form_name_rus"
        case statusIssueFormNameEng = "status_issue_form_name_eng"
        case qgcRewriteType = "qgc_rewrite_type"
        case allBondTypes = "all_bond_types"
    }
}

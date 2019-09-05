//
//  UserData.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 22.07.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//
//  A model object that stores app data.


import Foundation

final class UserData: ObservableObject {
    
    func reset() {
        emissionMetadata = nil
        flowMetadata = nil
        emissions = []
        flows = []
        portfolioNames = []
        favoriteEmissions = [:]
        positions = []
        cashFlows = []
        baseDate = Date()
    }
    
    private let defaults = UserDefaults.standard
    
    var hasAtLeastTwoPortfolios: Bool {
        positions.map({ $0.portfolioName }).removingDuplicates().count > 1
    }
    
    var emitents: [String] {
        emissions.map { $0.emitentNameRus }.removingDuplicates()
    }

    @Published var emissionMetadata: CBondEmissionMetadata? = emissionMetadataData {
        didSet {
            saveJSON(data: emissionMetadata, filename: "emissionMetadata.json")
        }
    }
    
    @Published var flowMetadata: CBondFlowMetadata? = flowMetadataData {
        didSet {
            saveJSON(data: flowMetadata, filename: "flowMetadata.json")
        }
    }
    
    @Published var emissions = emissionData {
        didSet {
            saveJSON(data: emissions, filename: "emissions.json")
        }
    }
    
    @Published var flows = cashFlowData {
        didSet {
            saveJSON(data: flows, filename: "flows.json")
        }
    }
    
    @Published var portfolioNames: [String] = portfolioNamesData {
        didSet {
            saveJSON(data: portfolioNames, filename: "portfolioNames.json")
        }
    }
    
    @Published var favoriteEmissions: [EmissionID: Bool] = favoriteEmissionsData {
        didSet {
            saveJSON(data: favoriteEmissions, filename: "favoriteEmissions.json")
        }
    }
    
    @Published var positions: [Position] = positionData {
        didSet {
            saveJSON(data: positions, filename: "positions.json")
        }
    }
    
    @Published var baseDate = Date()
    
    @Published var cashFlows: [CalendarCashFlow] = calendarCashFlowData
//    {
//        print("\n\(flows.count) - total # of flows in database")
//        /// get a slice of `emissions` for those in `positions` only
//        let flowsForEmissionsInPortfolio = flows.filter {
//            positions.map({ $0.emissionID }).contains($0.emissionID)
//
//        }
//        print("\(flowsForEmissionsInPortfolio.count) - flows of interest (flowsForEmissionsInPortfolio)")
//
//        /// `testing`if there any records with coupon ad redemption simultaneously
//        let flowsWithCouponAndRedemption = flows.filter {
//            $0.cuponSum > 0 && $0.redemtion > 0
//        }
//        print("\(flowsWithCouponAndRedemption.count) - flowsWithCouponAndRedemption")
//
//        var cashFlows: [CalendarCashFlow] = []
//
//        ///  loop through `all positions` `and selected flows` (with emissions in positions) to create a cashFlows array
//        for position in positions {
//            for flow in flowsForEmissionsInPortfolio {
//
//                ///  match by `emissionID` field
//                if position.emissionID == flow.emissionID {
//
//                    ///  get `emitent` from emissions and create `instrument` from emission name (documentRus) (get rid of emitent name in documentRus)
//                    let emission = emissions.first { $0.id == position.emissionID }
//                    let emitent = emission?.emitentNameRus ?? "#n/a"
//                    let doc = emission?.documentRus
//                    let instrument = String(doc?.dropFirst(2 + (doc?.split(separator: ",")[0].count ?? 0)) ?? "#n/a")
//
//                    /// append  non-zero `coupon ` flow
//                    if flow.cuponSum > 0 {
//                        let cashFlowCoupon = CalendarCashFlow(date: flow.date, portfolioName: position.portfolioName, emitent: emitent, instrument: instrument, amount: Int(Double(position.qty) * flow.cuponSum), type: .coupon)
//                        cashFlows.append(cashFlowCoupon)
//                    }
//
//                    /// append non-zero `face` (principal) flow
//                    if flow.redemtion > 0 {
//                        let cashFlowPrincipal = CalendarCashFlow(date: flow.date, portfolioName: position.portfolioName, emitent: emitent, instrument: instrument, amount: Int(Double(position.qty) * flow.redemtion), type: .face)
//                        cashFlows.append(cashFlowPrincipal)
//                    }
//                }
//            }
//        }
//        print("\(cashFlows.count) - cashFlows.count")
//        print(cashFlows)
//        return cashFlows
//    }
//
}

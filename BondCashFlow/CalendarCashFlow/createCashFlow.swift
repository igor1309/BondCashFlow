//
//  createCashFlow.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 04.09.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import Foundation

extension CFCalendar {
    func createCashFlow() -> [CalendarCashFlow] {
        print("\n\(self.userData.flows.count) - total # of flows in database")
        /// get a slice of `emissions` for those in `positions` only
        let flowsForEmissionsInPortfolio = self.userData.flows.filter {
            self.userData.positions.map({ $0.emissionID }).contains($0.emissionID)
            
        }
        print("\(flowsForEmissionsInPortfolio.count) - flows of interest (flowsForEmissionsInPortfolio)")
        
        /// `testing`if there any records with coupon ad redemption simultaneously
        let flowsWithCouponAndRedemption = self.userData.flows.filter {
            $0.cuponSum > 0 && $0.redemtion > 0
        }
        print("\(flowsWithCouponAndRedemption.count) - flowsWithCouponAndRedemption")
        
        var cashFlows: [CalendarCashFlow] = []
        
        ///  loop through `all positions` `and selected flows` (with emissions in positions) to create a cashFlows array
        for position in self.userData.positions {
            for flow in flowsForEmissionsInPortfolio {
                
                ///  match by `emissionID` field
                if position.emissionID == flow.emissionID {
                    
                    ///  get `emitent` from emissions and create `instrument` from emission name (documentRus) (get rid of emitent name in documentRus)
                    let emission = self.userData.emissions.first { $0.id == position.emissionID }
                    let emitent = emission?.emitentNameRus ?? "#n/a"
                    let doc = emission?.documentRus
                    let instrument = String(doc?.dropFirst(2 + (doc?.split(separator: ",")[0].count ?? 0)) ?? "#n/a")
                    
                    /// append  non-zero `coupon ` flow
                    if flow.cuponSum > 0 {
                        let cashFlowCoupon = CalendarCashFlow(date: flow.date, portfolioName: position.portfolioName, emitent: emitent, instrument: instrument, amount: Int(Double(position.qty) * flow.cuponSum), type: .coupon)
                        cashFlows.append(cashFlowCoupon)
                    }
                    
                    /// append non-zero `face` (principal) flow
                    if flow.redemtion > 0 {
                        let cashFlowPrincipal = CalendarCashFlow(date: flow.date, portfolioName: position.portfolioName, emitent: emitent, instrument: instrument, amount: Int(Double(position.qty) * flow.redemtion), type: .face)
                        cashFlows.append(cashFlowPrincipal)
                    }
                }
            }
        }
        print("\(cashFlows.count) - cashFlows.count")
        print(cashFlows)
        return cashFlows
    }
}

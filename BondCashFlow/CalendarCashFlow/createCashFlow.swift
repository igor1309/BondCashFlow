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
        var cashFlows: [CalendarCashFlow] = []
        
        ///  loop through `all positions` `and selected flows` (with emissions in positions) to create a cashFlows array
        for position in self.userData.positions {
            for flow in userData.workingFlows {
                
                ///  match by `emissionID` field
                if position.emissionID == flow.emissionID {
                    
                    ///  get `emitent` from emissions and create `instrument` from emission name (documentRus) (get rid of emitent name in documentRus)
                    let emission = self.userData.emissions.first { $0.id == position.emissionID }
                    let emitent = emission?.emitentNameRus ?? "#n/a"
                    let doc = emission?.documentRus
                    let instrument = String(doc?.dropFirst(2 + (doc?.split(separator: ",")[0].count ?? 0)) ?? "#n/a")
                    
                    /// append  non-zero `coupon ` flow
                    if flow.cuponSum > 0 {
                        let cashFlowCoupon = CalendarCashFlow(date: flow.date, portfolioID: position.portfolioID, emitent: emitent, instrument: instrument, amount: Int(Double(position.qty) * flow.cuponSum), type: .coupon)
                        cashFlows.append(cashFlowCoupon)
                    }
                    
                    /// append non-zero `face` (principal) flow
                    if flow.redemtion > 0 {
                        let cashFlowPrincipal = CalendarCashFlow(date: flow.date, portfolioID: position.portfolioID, emitent: emitent, instrument: instrument, amount: Int(Double(position.qty) * flow.redemtion), type: .face)
                        cashFlows.append(cashFlowPrincipal)
                    }
                }
            }
        }
        
        print("created cashFlows, cashFlows.count is \(cashFlows.count)")
        
        return cashFlows
    }
}

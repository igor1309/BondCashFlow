//
//  CashFlowRow.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 23.07.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct CashFlowRow2: View {
    @EnvironmentObject var userData: UserData
    
    var weekNo: Int
    var flows: [CalendarCashFlow]
    
    @State private var showDetail = false
    
    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            
            //  MARK:- ПРОБЛЕМА: при изменении baseDate ZStack с боковой полосой с пустыми или заполненными точками НЕ ПЕРЕРИСОВЫВАЕТСЯ!!
            TimelineGraphForRow(hasData: flows.count > 0)
            
            VStack(alignment: .leading, spacing: 1) {
                
                HStack(alignment: .center) {
                    Text(self.userData.baseDate.addWeeks(weekNo).firstDayOfWeekRU.toString())
                        .font(.caption)
                        .foregroundColor(.systemOrange)
                        .fontWeight(flows.count > 0 ? .light : .ultraLight)
                    
                    Spacer()
                    
                    if flows.count > 0 {
                        //  MARK:- TODO: finish this: map, reduce
                        //  сумма за неделю
                        Text(flows.reduce(0, { $0 + $1.amount }).formattedGrouped)
                            .font(.headline)
                            .foregroundColor(.systemOrange)
                            .fontWeight(.light)
                    }
                }
                
                CashFlowCell2(
                    coupon: self.flows
                        .filter { $0.type == .coupon }
                        .reduce(0, { $0 + $1.amount }),
                    face: self.flows
                        .filter { $0.type == .face }
                        .reduce(0, { $0 + $1.amount }))
                    
                    .onTapGesture {
                        self.showDetail = true
                }
            }
        }
        .fixedSize(horizontal: false, vertical: true)
            
        .sheet(isPresented: $showDetail) {
            CalendarCashFlowDetail(flows: self.flows)
                .environmentObject(self.userData)
        }
    }
}

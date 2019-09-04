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
                
                VStack {
                    ForEach(flows, id: \.self) { flow in

                        CashFlowCell(hasData: self.flows.count > 0,
                                     start: self.userData.baseDate.addWeeks(self.weekNo).firstDayOfWeekRU,
                                     end: self.userData.baseDate.addWeeks(self.weekNo + 1).firstDayOfWeekRU,
                                     cashFlow: flow)
                            .environmentObject(self.userData)
                    }
                }
            }
        }
        .fixedSize(horizontal: false, vertical: true)
    }
}


struct CashFlowRow: View {
    @EnvironmentObject var userData: UserData
    @State private var hasData = false
    
    var weekNo: Int
    
    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            
            //  MARK:- ПРОБЛЕМА: при изменении baseDate ZStack с боковой полосой с пустыми или заполненными точками НЕ ПЕРЕРИСОВЫВАЕТСЯ!!
            TimelineGraphForRow(hasData: hasData)
            
            VStack(alignment: .leading, spacing: 1) {
                
                HStack(alignment: .center) {
                    Text(self.userData.baseDate.addWeeks(weekNo).firstDayOfWeekRU.toString()) // + " (W\(weekNo))")
                        .font(.caption)
                        .foregroundColor(.systemOrange)
                        .fontWeight(hasData ? .light : .ultraLight)
                    
                    Spacer()
                    
                    if hasData {
                        //  MARK:- TODO: finish this: map, reduce
                        //  сумма за неделю
                        Text(10_000_000.formattedGrouped)
                            .font(.headline)
                            .foregroundColor(.systemOrange)
                            .fontWeight(.light)
                    }
                }
                
                VStack {
                    ForEach(self.userData.cashFlows
                        
                    ) { cashFlow in
                        
                        //                        if (self.userData.baseDate.addWeeks(self.weekNo).firstDayOfWeekRU <= cashFlow.date)
                        //                            && (cashFlow.date <= self.userData.baseDate.addWeeks(self.weekNo + 1).firstDayOfWeekRU)
                        //                        {
                        CashFlowCell(hasData: self.hasData,
                                     start: self.userData.baseDate.addWeeks(self.weekNo).firstDayOfWeekRU,
                                     end: self.userData.baseDate.addWeeks(self.weekNo + 1).firstDayOfWeekRU,
                                     cashFlow: cashFlow)
                            .environmentObject(self.userData)
                            .onAppear(perform: { self.hasData = true })
                        //                        }
                    }
                }
            }
        }
        .fixedSize(horizontal: false, vertical: true)
    }
}


#if DEBUG
struct CashFlowRow_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            VStack(spacing: 0) {
                CashFlowRow(weekNo: 8)
                CashFlowRow(weekNo: 2)
                CashFlowRow(weekNo: 6)
                CashFlowRow(weekNo: 8)
                CashFlowRow(weekNo: 2)
                CashFlowRow(weekNo: 6)
            }
            .environment(\.sizeCategory, .extraExtraLarge)
            .environmentObject(UserData())
        }
        .environment(\.colorScheme, .dark)
        //        .previewLayout(.sizeThatFits)
    }
}
#endif

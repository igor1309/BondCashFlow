//
//  CashFlowGrid.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 23.07.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct CashFlowGrid: View {
    
    //  MARK: - TODO filter by selected portfolio
    
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var settings: SettingsStore
    //    @Binding var baseDate: Date
    @State private var activeWeek = 0
    var startDate: Date
    
    var cashFlows: [CalendarCashFlow]
        
    var body: some View {
        HStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 4) {
                    ForEach(0..<settings.weeksToShowInCalendar) { weekNo in
                        CashFlowGridColumn(activeWeek: self.$activeWeek, cashFlows: self.cashFlows, weekNo: weekNo, date: self.startDate.addWeeks(weekNo))
                        //                            .environmentObject(self.userData)
                    }
                }
            }
        }
    }
}

#if DEBUG
struct CashFlowGrid_Previews: PreviewProvider {
    static var previews: some View {
        Group {
//            CashFlowGrid(cashFlows: [CalendarCashFlow(date: Date().addWeeks(6), portfolioName: "Optimus", emitent: "VTB", instrument: "GHS-457", amount: 12345, type: .coupon)])
//                .padding()
//
            NavigationView {
                VStack {
                    CashFlowGrid(startDate: Date(), cashFlows: [CalendarCashFlow(date: Date().addWeeks(6), portfolioName: "Optimus", emitent: "VTB", instrument: "GHS-457", amount: 12345, type: .coupon)])
                        .padding()
                    
                    Spacer()
                }
            .navigationBarTitle("Календарь")
            }
                //                .preferredColorScheme(.dark)
            .environment(\.colorScheme, .dark)
        }
        .environmentObject(UserData())
        .environmentObject(SettingsStore())
    }
}
#endif

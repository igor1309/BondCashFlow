//
//  CashFlowGrid.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 23.07.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct CashFlowGrid: View {
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var settings: SettingsStore
    @State private var activeWeek = 0
    var startDate: Date
    var cashFlows: [CalendarCashFlow]
    
    var body: some View {
        HStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 4) {
                    ForEach(0..<settings.weeksToShowInCalendar) { weekNo in
                        CashFlowGridColumn(activeWeek: self.$activeWeek,
                                           cashFlows: self.cashFlows
                                            .filter({
                                                (self.userData.baseDate.addWeeks(weekNo).firstDayOfWeekRU <= $0.date)
                                                    && ($0.date < self.userData.baseDate.addWeeks(weekNo + 1).firstDayOfWeekRU)
                                            }),
                                           weekNo: weekNo,
                                           weekStartDate: self.startDate.addWeeks(weekNo))
                    }
                }
            }
        }
    }
}

#if DEBUG
struct CashFlowGrid_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            VStack {
                CashFlowGrid(startDate: Date(),
                             cashFlows: [CalendarCashFlow(date: Date().addWeeks(3), portfolioName: "Optimus", emitent: "VTB", instrument: "GHS-457", amount: 12345, type: .coupon)])
                    .padding()
                
                Spacer()
            }
            .navigationBarTitle("Календарь")
        }
        .environmentObject(UserData())
        .environmentObject(SettingsStore())
        .environment(\.colorScheme, .dark)
    }
}
#endif

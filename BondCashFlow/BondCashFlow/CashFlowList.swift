//
//  CashFlowList.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 22.07.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct CashFlowList: View {
    
    //  MARK: - TODO filter by selected portfolio
    
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var settings: SettingsStore
    
    var cashFlows: [CalendarCashFlow]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 0) {
                ForEach(0 ..< settings.weeksToShowInCalendar) { weekNo in
                    
                    CashFlowRow2(weekNo: weekNo, flows: self.cashFlows
                        .filter({
                            (self.userData.baseDate.addWeeks(weekNo).firstDayOfWeekRU <= $0.date)
                                && ($0.date < self.userData.baseDate.addWeeks(weekNo + 1).firstDayOfWeekRU)
                        })
                    )
                        .environmentObject(self.userData)
                }
            }
        }
    }
}

#if DEBUG
struct CashFlowList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CashFlowList(cashFlows: [CalendarCashFlow(date: Date().addWeeks(6), portfolioID: UUID(uuidString: "9009E038-AF68-4E55-A15E-F6C5059B79BD") ?? UUID(), emitent: "VTB", instrument: "GHS-457", amount: 12345, type: .coupon)])
                
                .navigationBarTitle("Cash Flow")
        }
        .environmentObject(UserData())
        .environmentObject(SettingsStore())
        .preferredColorScheme(.dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}
#endif

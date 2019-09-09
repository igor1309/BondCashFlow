//
//  CashFlowTimeline.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 23.07.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct CashFlowTimeline: View {
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var settings: SettingsStore
    
    var cashFlows: [CalendarCashFlow]
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                CashFlowGrid(startDate: settings.startDate, cashFlows: cashFlows)
                    .environmentObject(self.userData)
                    .padding()
            }
        }
    }
}

#if DEBUG
struct CashFlowTimeline_Previews: PreviewProvider {
    static var previews: some View {
        CashFlowTimeline(cashFlows: [CalendarCashFlow(date: Date().addWeeks(6), portfolioID: UUID(uuidString: "9009E038-AF68-4E55-A15E-F6C5059B79BD") ?? UUID(), emitent: "VTB", instrument: "GHS-457", amount: 12345, type: .coupon)])
            .environmentObject(UserData())
            .environmentObject(SettingsStore())
    }
}
#endif

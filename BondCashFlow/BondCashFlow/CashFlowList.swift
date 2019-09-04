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
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 0) {
                //  MARK:- псевдохак чтобы ScrollView скроллился наверх сам
                //                    Text("Base Date: " + userData.baseDate.toString())
                //                    .font(.caption)
                //                    .foregroundColor(Color.secondary)
                //                    .padding(.vertical)
                //                    
                ForEach(0 ..< settings.weeksToShowInCalendar) { weekNo in
                    
                    CashFlowRow2(weekNo: weekNo, flows: self.userData.cashFlows
                        .filter({
                            (self.userData.baseDate.addWeeks(weekNo).firstDayOfWeekRU <= $0.date)
                                && ($0.date < self.userData.baseDate.addWeeks(weekNo + 1).firstDayOfWeekRU)
                        })
                    )
                        .environmentObject(self.userData)
                }
                
                
                //                ForEach(0 ..< 52) { weekNo in
                //                    CashFlowRow(weekNo: weekNo)
                //                        .environmentObject(self.userData)
                //                }
            }
        }
        //            .padding(.top)
    }
}

#if DEBUG
struct CashFlowList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CashFlowList()
                
                .navigationBarTitle("Cash Flow")
        }
        .environmentObject(UserData())
        .environmentObject(SettingsStore())
        .preferredColorScheme(.dark)
        .environment(\.sizeCategory, .extraLarge)
    }
}
#endif

//
//  CashFlowView.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 23.07.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct CashFlowView: View {
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var settings: SettingsStore
    
    @State private var cashFlows: [CalendarCashFlow] = []
    var body: some View {
        
        //  MARK: - TODO filter by selected portfolio
        
        VStack(alignment: .leading, spacing: 0) {
            
            HStack {
                Spacer()
                
                Text("Start Date: \(settings.startDate.toString()) | Base Date: \(userData.baseDate.toString())")
                    .font(.caption)
                    .foregroundColor(Color.secondary)
                    .padding(.horizontal)
            }
            
            CashFlowGrid(startDate: settings.startDate, cashFlows: cashFlows)
                .padding(.horizontal)
                .padding(.vertical, 4)
            
            CashFlowList(cashFlows: cashFlows)
                //  MARK: old edition:
                // ScrollView(.vertical, showsIndicators: false) {
                //     VStack(alignment: .leading, spacing: 0) {
                //         ForEach(0 ..< 52) { weekNo in
                //             CashFlowRow(weekNo: weekNo)
                //                 .environmentObject(self.userData)
                //         }
                //     }
                // }
                .padding(.horizontal)
        }
        .onAppear(perform: {
            self.cashFlows = self.userData.calculateCashFlows()
        })
        
    }
}

#if DEBUG
struct CashFlowView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            //            CashFlowView(cashFlows: [CalendarCashFlow(date: Date().addWeeks(6), portfolioName: "Optimus", emitent: "VTB", instrument: "GHS-457", amount: 12345, type: .coupon)])
            CashFlowView()
                .navigationBarTitle("Потоки")
            
        }
        .environmentObject(UserData())
        .environmentObject(SettingsStore())
        .preferredColorScheme(.dark)
    }
}
#endif

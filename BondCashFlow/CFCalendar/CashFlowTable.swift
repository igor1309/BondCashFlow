//
//  CashFlowTable.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 06.09.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct CashFlowTable: View {
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var settings: SettingsStore
    
    @State private var cashFlows: [CalendarCashFlow] = []
    
    var body: some View {
        //        VStack {
        //            Toggle(isOn: $userData.isFutureFlowsOnly) {
        //                Text("Только будущие потоки")
        //            }
        //            .padding(.horizontal)
        //            .foregroundColor(.systemOrange)
        //
        List {
            ForEach(cashFlows
                .filter {
                    if self.userData.isFutureFlowsOnly {
                        return $0.date >= self.settings.startDate
                    } else {
                        return true
                    }
            }
            .sorted(by: {
                ($0.date, $0.emitent, $0.instrument)
                    < ($1.date, $1.emitent, $1.instrument) }), id: \.self) { flow in
                        
                        FlowRow3(flow: flow)
            }
        }
        .onAppear {
            self.cashFlows = self.userData.calculateCashFlows()
        }
            //        }
            
            .navigationBarTitle(userData.isFutureFlowsOnly ? "Будущие потоки" : "Все потоки")
            
            .navigationBarItems(trailing: Toggle(isOn: $userData.isFutureFlowsOnly) {
                Text("Только будущие".uppercased())
                    .font(.caption)
            }
            .padding(.horizontal)
            .foregroundColor(.systemOrange))
    }
}

struct CashFlowTable_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CashFlowTable()
                .environmentObject(UserData())
                .environmentObject(SettingsStore())
        }
    }
}

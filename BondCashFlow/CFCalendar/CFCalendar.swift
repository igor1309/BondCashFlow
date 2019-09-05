//
//  CFCalendar.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 24.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct CFCalendar: View {
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var settings: SettingsStore
    @State private var showPortfolioFilter = false
    
    var body: some View {
        CashFlowView()
//            .onAppear(perform: {
//                self.userData.cashFlows = self.createCashFlow()
//            })
            
            .navigationBarTitle("Потоки")
            
            .navigationBarItems(
                leading:
                Button(action: {
                    self.showPortfolioFilter = true
                }) {
                    Image(systemName: settings.isAllPortfoliosSelected ? "briefcase" : "briefcase.fill")
                        .padding(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 16))
                }
                .disabled(!self.userData.hasAtLeastTwoPortfolios))
            
            .sheet(isPresented: $showPortfolioFilter,
                   content: { PotfolioFilter().environmentObject(self.userData) })
    }
}

struct CFCalendar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CFCalendar()
                .environmentObject(UserData())
        }
    }
}

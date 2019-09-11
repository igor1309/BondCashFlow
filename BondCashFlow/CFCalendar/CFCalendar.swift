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
        
        VStack(alignment: .leading, spacing: 0) {
            
            HStack {
                Spacer()
                
                Text("Start Date: \(settings.startDate.toString()) | Base Date: \(userData.baseDate.toString())")
                    .font(.caption)
                    .foregroundColor(Color.secondary)
                    .padding(.horizontal)
            }
            
            CashFlowGrid(startDate: settings.startDate, cashFlows: userData.cashFlows)
                .padding(.horizontal)
                .padding(.vertical, 4)
            
            CashFlowList(cashFlows: userData.cashFlows)
                .padding(.horizontal)
        }
            
        .navigationBarTitle("Потоки")
            
        .navigationBarItems( leading:
            LeadingButtonSFSymbol(systemName: settings.isAllPortfoliosSelected ? "briefcase" : "briefcase.fill") {
                self.showPortfolioFilter = true
            }
            .disabled(!self.userData.hasAtLeastTwoPortfolios)
            .contextMenu {
                if !self.settings.isAllPortfoliosSelected {
                    Button(action: {
                        self.settings.isAllPortfoliosSelected = true
                    }) {
                        HStack {
                            Image(systemName: "briefcase")
                            Spacer()
                            Text("все портфели")
                        }
                    }
                }
        })
            
            .sheet(isPresented: $showPortfolioFilter,
                   content: {
                    PotfolioFilter(
                        isAllPortfoliosSelected: self.settings.isAllPortfoliosSelected,
                        selectedPortfolio: self.settings.selectedPortfolio)
                        
                        .environmentObject(self.userData)
                        .environmentObject(self.settings)
            })
    }
}

struct CFCalendar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CFCalendar()
                .environmentObject(UserData())
                .environmentObject(SettingsStore())
        }
        .environment(\.colorScheme, .dark)
    }
}

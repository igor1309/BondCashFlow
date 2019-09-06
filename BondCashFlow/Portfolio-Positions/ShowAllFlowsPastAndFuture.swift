//
//  ShowAllFlowsPastAndFuture.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 04.09.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

//  MARK: TODO: redemption!!!!!!!
struct FlowRow3: View {
    var flow: CalendarCashFlow
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(flow.date.toString())
                
                Spacer()
                
                Text(flow.type.id)
                    .font(.footnote)
                    .fontWeight(.thin)
                    .foregroundColor(.systemOrange)
                
                Text(flow.amount.formattedGrouped)
            }
            
            HStack {
                Text(flow.portfolioName)
                    .fontWeight(.light)
                    .foregroundColor(.systemOrange)
                
                Spacer()
                
                Text(flow.emitent)
                
                Text(flow.instrument)
            }
            .font(.footnote)
            .foregroundColor(.secondary)
        }
    }
}


struct ShowAllFlowsPastAndFuture: View {
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var settings: SettingsStore
    @Environment(\.presentationMode) var presentation
    
    @State private var cashFlows: [CalendarCashFlow] = []
    
    var body: some View {
        NavigationView {
            VStack {
                Toggle(isOn: $settings.isFutureFlowsOnly) {
                    Text("Только будущие потоки")
                }
                .padding(.horizontal)
                .foregroundColor(.systemOrange)
                
                List {
                    ForEach(cashFlows
                        .filter {
                            if self.settings.isFutureFlowsOnly {
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
                .onAppear(perform: {
                    self.cashFlows = self.userData.calculateCashFlows()
                })
            }
                
            .navigationBarTitle(settings.isFutureFlowsOnly ? "Будущие потоки" : "Все потоки")
                
            .navigationBarItems(trailing: TrailingButton(name: "Закрыть", closure: {
                self.presentation.wrappedValue.dismiss()
            }))
        }
    }
}

struct ShowAllFlowsPastAndFuture_Previews: PreviewProvider {
    static var previews: some View {
        ShowAllFlowsPastAndFuture()
            .environmentObject(UserData())
            .environmentObject(SettingsStore())
            .environment(\.colorScheme, .dark)
    }
}

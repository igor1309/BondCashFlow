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
    @EnvironmentObject var userData: UserData
    var flow: CalendarCashFlow
    
    var body: some View {
        Row(topline: userData.portfolios.first(where: { $0.id == flow.portfolioID })?.name ?? "#н/д",
            title: flow.date.toString(),
            detail: flow.amount.formattedGrouped,
            subtitle: flow.emitent + " " + flow.instrument,
            subdetail: flow.type.id)
    }
}

struct ShowAllFlowsPastAndFuture: View {
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var settings: SettingsStore
    @Environment(\.presentationMode) var presentation
    
    @State private var cashFlows: [CalendarCashFlow] = []
    
    var body: some View {
        Group {
            Toggle(isOn: $settings.isFutureFlowsOnly) {
                Text("Только будущие потоки")
            }
            .padding([.top, .horizontal])
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
            .onAppear {
                self.cashFlows = self.userData.calculateCashFlows()
            }
        }
            
        .navigationBarTitle(settings.isFutureFlowsOnly ? "Будущие потоки" : "Все потоки", displayMode: .inline)
            
        .navigationBarItems(
            trailing: TrailingButton(name: "Закрыть", closure: {
                self.presentation.wrappedValue.dismiss()
            })
        )
    }
}

struct ShowAllFlowsPastAndFuture_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ShowAllFlowsPastAndFuture()
                .environmentObject(UserData())
                .environmentObject(SettingsStore())
                .environment(\.colorScheme, .dark)
        }
    }
}
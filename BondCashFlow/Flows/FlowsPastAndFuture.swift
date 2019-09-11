//
//  FlowsPastAndFuture.swift
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

struct FlowsPastAndFuture: View {
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var settings: SettingsStore
    @Environment(\.presentationMode) var presentation
    
    @State private var cashFlows: [CalendarCashFlow] = []
    
    @State private var showModal = false
    @State private var modal: Modal = .filter
    
    
    private enum Modal {
        case filter, addPortfolio, addPosition, addIssue, allFlows, positionsByEmission
    }
    
    var body: some View {
        List {
            Text("Работа над фильтром пока продолжается").foregroundColor(.systemTeal)
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
            
        .navigationBarTitle(settings.isFutureFlowsOnly ? "Будущие потоки" : "Все потоки")
            
        .navigationBarItems(
            leading: LeadingButtonSFSymbol(systemName: settings.isAllPortfoliosSelected ? "briefcase" : "briefcase.fill") {
                if self.userData.hasAtLeastTwoPortfolios {
                    self.modal = .filter
                    self.showModal = true
                }
            }
            .disabled(!self.userData.hasAtLeastTwoPortfolios),
            
            trailing: Toggle(isOn: $settings.isFutureFlowsOnly) {
                Text("Только будущие".uppercased())
            }
            .padding([.top, .horizontal])
            .font(.footnote)
            .foregroundColor(.systemOrange)
        )
        
        .sheet(isPresented: $showModal, content: {
            if self.modal == .filter {
                PotfolioFilter(
                    isAllPortfoliosSelected: self.settings.isAllPortfoliosSelected,
                    selectedPortfolio: self.settings.selectedPortfolio)
                    .environmentObject(self.userData)
                    .environmentObject(self.settings)
            }
        })
    }
}

struct FlowsPastAndFuture_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FlowsPastAndFuture()
                .environmentObject(UserData())
                .environmentObject(SettingsStore())
                .environment(\.colorScheme, .dark)
        }
    }
}

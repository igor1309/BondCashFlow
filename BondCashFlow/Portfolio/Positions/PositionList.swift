//
//  PositionList.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 24.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct PositionList: View {
    var positions: [Position]
    
    var body: some View {
        List {
            ForEach(positions, id: \.self) { position in
                PositionRow(position: position)
            }
        }
    }
}


struct PositionListView: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var settings: SettingsStore
    
    @State private var showModal = false
    @State private var modal: Modal = .filter
    
    private enum Modal {
        case filter, addPortfolio, addPosition, addIssue, allFlows, positionsByEmission
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text(settings.isAllPortfoliosSelected ? "все портфели" : "Портфель " + settings.selectedPortfolio)
                .foregroundColor(.secondary)
                .font(.caption)
                .padding(.horizontal)
            
            PositionList(positions: userData.positions
                .filter({
                    if settings.isAllPortfoliosSelected {
                        return true
                    } else {
                        return $0.portfolioID == settings.selectedPortfolioID
                    }
                })
                .sorted(by: {
                    if settings.isAllPortfoliosSelected {
                        return ($0.emissionID) < ($1.emissionID)
                    } else {
                        return $0.emissionID < $1.emissionID
                    }
                }))
                .environmentObject(self.userData)
        }
            
        .navigationBarTitle("Позиции")
            
        .navigationBarItems(
            leading:
            LeadingButtonSFSymbol(systemName: settings.isAllPortfoliosSelected ? "briefcase" : "briefcase.fill") {
                if self.userData.hasAtLeastTwoPortfolios {
                    self.modal = .filter
                    self.showModal = true
                }
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
    }
}

struct Portfolio_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PositionListView()
        }
        .environmentObject(UserData())
        .environmentObject(SettingsStore())
        .environment(\.colorScheme, .dark)
    }
}

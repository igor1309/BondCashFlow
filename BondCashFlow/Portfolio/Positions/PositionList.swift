//
//  PositionList.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 24.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct PositionList: View {
    @EnvironmentObject var userData: UserData
    
    var positions: [Position]
    
    var body: some View {
        List {
            ForEach(positions.indexed(), id: \.1.id) { index, _ in
                PositionRow(position: self.$userData.positions[index])
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
    
    private func addPosition() {
        modal = .addPosition
        showModal = true
    }
    
    var body: some View {
        
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
            
            .navigationBarTitle("Позиции")
            
            .navigationBarItems(
                leading:
                HStack {
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
                    }
                    
                    Text(settings.isAllPortfoliosSelected ? "все портфели" : "Портфель " + settings.selectedPortfolio)
                    .foregroundColor(.secondary)
                    .font(.caption)
                },
                
                trailing: TrailingButtonSFSymbol(systemName: "plus") {
                    self.addPosition()
                }
        )
            
            .sheet(isPresented: $showModal, content: {
                if self.modal == .addPosition {
                    NavigationView {
                        CreatePosition()
                            .environmentObject(self.userData)
                            .environmentObject(self.settings)
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

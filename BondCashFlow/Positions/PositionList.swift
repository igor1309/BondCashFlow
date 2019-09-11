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
    
    private func addPosition() {
        modal = .addPosition
        showModal = true
    }
    
    var body: some View {
        
        PositionList(positions: userData.positionsToPresent)
            
            .environmentObject(self.userData)
            
            .navigationBarTitle("Позиции")
            
            .navigationBarItems(
                leading: LeadingButtonSFSymbol(systemName: userData.selectedPortfolioID == nil ? "briefcase" : "briefcase.fill") {
                    if self.userData.hasAtLeastTwoPortfolios {
                        self.modal = .filter
                        self.showModal = true
                    }
                }
                .disabled(!self.userData.hasAtLeastTwoPortfolios),
                
                trailing: TrailingButtonSFSymbol(systemName: "plus") {
                    self.addPosition()
            })
            
            .sheet(isPresented: $showModal, content: {
                if self.modal == .addPosition {
                    NavigationView {
                        CreatePosition()
                            .environmentObject(self.userData)
                            .environmentObject(self.settings)
                    }
                }
                
                if self.modal == .filter {
                    PotfolioFilter()
                        .environmentObject(self.userData)
                        .environmentObject(self.settings)
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

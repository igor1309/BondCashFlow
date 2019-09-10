//
//  PortfolioView.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 09.09.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct PortfolioView: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var settings: SettingsStore
    
    @State private var showActions = false
    @State private var showModal = false
    @State private var modal: Modal = .filter
    
    private enum Modal {
        case filter, addPortfolio, addPosition, addIssue, allFlows, positionsByEmission
    }
    
    private func addPosition() {
        modal = .addPosition
        showModal = true
    }
    private func addPortfolio() {
        modal = .addPortfolio
        showModal = true
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            PortfolioList()
        }
            
        .navigationBarItems(
            leading: HStack {
                LeadingButtonSFSymbol(systemName: "doc.text") {
                    self.modal = .positionsByEmission
                    self.showModal = true
                }
                
                LeadingButtonSFSymbol(systemName: "flowchart") {
                    self.modal = .allFlows
                    self.showModal = true
                }
            },
            
            trailing: HStack {
                TrailingButtonSFSymbol(systemName: "plus.square.on.square") {
                    self.showActions = true
                }
                
                TrailingButtonSFSymbol(systemName: "plus") {
                    self.addPosition()
                }
                .contextMenu {
                    Button(action: {
                        self.addPosition()
                    }) {
                        HStack {
                            Image(systemName: "briefcase")
                            Spacer()
                            Text("Новый портфель")
                        }
                    }
                }
        })
            
            .actionSheet(isPresented: $showActions, content: {
                ActionSheet(title: Text("Добавить"),
                            buttons: [
                                .cancel(Text("Отмена")),
                                .default(Text("Добавить позицию в портфель"),
                                         action: {
                                            self.addPosition() }),
                                .default(Text("Создать новый портфель"),
                                         action: {
                                            self.addPortfolio() })
                ])
            })
            
            .sheet(isPresented: $showModal, content: {
                
                if self.modal == .positionsByEmission {
                    NavigationView {
                        PositionsByEmissionList()
                            .environmentObject(self.userData)
                    }
                }
                
                if self.modal == .addPortfolio {
                    //  MARK: TODO решить нужно ли отдельно создавать портфель
                    //  и что делать с этим блоком
                    AddPortfolio(portfolioName: .constant(""))
                        .environmentObject(self.userData)
                }
                
                //if self.modal == .addPosition {
                //    AddPosition(proposedPortfolioName: userData.portfolios.first(where: { $0.id == self.settings.selectedPortfolioID }).name)
                //        .environmentObject(self.userData)
                //        .environmentObject(self.settings)
                //}
                
                if self.modal == .addIssue {
                    AddIssue()
                        .environmentObject(self.userData)
                }
                
                if self.modal == .allFlows {
                    NavigationView {
                        ShowAllFlowsPastAndFuture()
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

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PortfolioView()
        }
            
        .environmentObject(UserData())
        .environmentObject(SettingsStore())
        .environment(\.colorScheme, .dark)
    }
}

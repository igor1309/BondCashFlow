//
//  MainPortfolioView.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 09.09.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct MainPortfolioView: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var settings: SettingsStore
    
    @State private var showActions = false
    @State private var showModal = false
    @State private var modal: Modal = .filter
    
    private enum Modal {
        case filter, addPortfolio, addPosition, addIssue, allFlows
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
            
            Picker(selection: $settings.selectedPortfolioView, label: Text("")) {
                Text("портфели").tag("портфели")
                Text("по выпускам").tag("по выпускам")
                Text("позиции").tag("позиции")
            }
                //                .border(Color.systemPink)
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
            //            .border(Color.systemPink)
            
            if settings.selectedPortfolioView == "портфели" {
                PortfolioList()
            }
            
            if settings.selectedPortfolioView == "по выпускам" {
                GlobalPositionList()
            }
            
            if settings.selectedPortfolioView == "позиции" {
                PositionListView()
            }
        }
            
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
                
                if self.modal == .addPortfolio {
                    //  MARK: TODO решить нужно ли отдельно создавать портфель
                    //  и что делать с этим блоком
                    AddPortfolio(portfolioName: .constant(""))
                        .environmentObject(self.userData)
                }
                
                //                if self.modal == .addPosition {
                //                    AddPosition(proposedPortfolioName: userData.portfolios.first(where: { $0.id == self.settings.selectedPortfolioID }).name)
                //                        .environmentObject(self.userData)
                //                        .environmentObject(self.settings)
                //                }
                
                if self.modal == .addIssue {
                    AddIssue()
                        .environmentObject(self.userData)
                }
                
                if self.modal == .allFlows {
                    ShowAllFlowsPastAndFuture()
                        .environmentObject(self.userData)
                        .environmentObject(self.settings)
                }
                
                if self.modal == .filter {
                    PotfolioFilter()
                        .environmentObject(self.userData)
                        .environmentObject(self.settings)
                }
            })
        
    }
}

struct MainPortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MainPortfolioView()
        }
            
        .environmentObject(UserData())
        .environmentObject(SettingsStore())
        .environment(\.colorScheme, .dark)
    }
}

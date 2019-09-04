//
//  PortfolioView.swift
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


struct PortfolioView: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var settings: SettingsStore
    
    @State private var showActions = false
    @State private var showModal = false
    @State private var modal: Modal = .filter
    
    private enum Modal {
        case filter, addPortfolio, addPosition, addIssue
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
                        return $0.portfolioName == settings.selectedPortfolio
                    }
                })
                .sorted(by: {
                    if settings.isAllPortfoliosSelected {
                        return ($0.portfolioName, $0.emissionID) < ($1.portfolioName, $1.emissionID)
                    } else {
                        return $0.emissionID < $1.emissionID
                    }
                }))
                
                .navigationBarTitle("Позиции")
                
                .navigationBarItems(
                    leading: Button(action: {
                        if self.userData.hasAtLeastTwoPortfolios {
                            self.modal = .filter
                            self.showModal = true
                        }
                    }) {
                        Image(systemName: settings.isAllPortfoliosSelected ? "briefcase" : "briefcase.fill")
                            .padding(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 16))
                    }
                    .disabled(!self.userData.hasAtLeastTwoPortfolios),
                    
                    trailing: HStack {
                        Button(action: {
                            self.showActions = true
                        }) {
                            Image(systemName: "plus.square.on.square")
                                .foregroundColor(.secondary)
                                .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 0))
                        }
                        Button(action: {
                            self.modal = .addPosition
                            self.showModal = true
                        }) {
                            Image(systemName: "plus")
                                .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 0))
                        }
                })
                
                .actionSheet(isPresented: $showActions, content: {
                    ActionSheet(title: Text("Добавить"),
                                buttons: [
                                    .cancel(Text("Отмена")),
                                    .default(Text("Добавить позицию в портфель"),
                                             action: {
                                                self.modal = .addPosition
                                                self.showModal = true }),
                                    .default(Text("Добавить выпуск облигаций"),
                                             action: {
                                                self.modal = .addIssue
                                                self.showModal = true }),
                                    .default(Text("Создать новый портфель"),
                                             action: {
                                                self.modal = .addPortfolio
                                                self.showModal = true })
                    ])
                })
                
                .sheet(isPresented: $showModal, content: {
                    
                    if self.modal == .addPortfolio {
                        //  MARK: TODO решить нужно ли отдельно создавать портфель
                        //  и что делать с этим блоком
                        AddPortfolio(portfolioName: .constant(""))
                            .environmentObject(self.userData)
                    }
                    
                    if self.modal == .addPosition {
                        AddPosition()
                            .environmentObject(self.userData)
                            .environmentObject(self.settings)
                    }
                    
                    if self.modal == .addIssue {
                        AddIssue()
                            .environmentObject(self.userData)
                    }
                    
                    if self.modal == .filter {
                        PotfolioFilter()
                            .environmentObject(self.userData)
                            .environmentObject(self.settings)
                    }
                })
        }
    }
}

struct Portfolio_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PortfolioView()
        }
        .environmentObject(UserData())
        .environmentObject(SettingsStore())
    }
}

//
//  PortfolioView.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 24.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct PortfolioView: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var userData: UserData
    
    var portfolioNames: [String] { userData.portfolios.map({ $0.name }) }
    
    @State private var showActions = false
    @State private var showModal = false
    @State private var modal: Modal = .filter
    
    private enum Modal {
        case filter, addPortfolio, addPosition, addIssue
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(userData.isAllPortfoliosSelected ? "все портфели" : "Портфель " + userData.selectedPortfolio)
                .foregroundColor(.secondary)
                .font(.caption)
                .padding(.horizontal)
            
            List {
                if userData.isAllPortfoliosSelected {
                    ForEach(userData.portfolios) { portfolio in
                        ForEach(portfolio.positions) { position in
                            
//                            NavigationLink(destination: PositionDetail(portfolioName: portfolio.name, position: position)){
                                
                                PositionRow(portfolioName: portfolio.name, position: position)
//                            }
                        }
                    }
                } else {
                    if userData.selectedPortfolio.isNotEmpty {
                        ForEach(userData.portfolios.first(where: { $0.name == self.userData.selectedPortfolio })!.positions, id: \.self) { position in
                            
//                            NavigationLink(destination: PositionDetail(portfolioName: self.userData.selectedPortfolio, position: position)){
                                
                                PositionRow(portfolioName: self.userData.selectedPortfolio, position: position)
//                            }
                        }
                    } else {
                        /*@START_MENU_TOKEN@*/EmptyView()/*@END_MENU_TOKEN@*/
                    }
                }
            }
                
            .navigationBarTitle("Позиции")
                
            .navigationBarItems(
                leading: Button(action: {
                    if self.userData.hasAtLeastTwoPortfolios {
                        self.modal = .filter
                        self.showModal = true
                    }
                }) {
                    Image(systemName: "briefcase")
                }
                    //                .imageScale(.large)
                    .disabled(!self.userData.hasAtLeastTwoPortfolios),
                
                trailing: Button(action: {
                    self.showActions = true
                }) {
                    Image(systemName: "plus")
                }
            )
                
                .actionSheet(isPresented: $showActions, content: {
                    ActionSheet(title: Text("Добавить"),
                                //                            message: Text(""),
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
                        AddPortfolio().environmentObject(self.userData)
                    }
                    
                    if self.modal == .addPosition {
                        AddPosition().environmentObject(self.userData)
                    }
                    
                    if self.modal == .addIssue {
                        AddIssue().environmentObject(self.userData)
                    }
                    
                    if self.modal == .filter {
                        PotfolioFilter().environmentObject(self.userData)
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
    }
}

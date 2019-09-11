//
//  PortfolioDetail.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 09.09.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct PortfolioDetail: View {
    @EnvironmentObject var userData: UserData
    @Environment(\.presentationMode) var presentation
    
    var portfolio: Portfolio
    @State private var draft: Portfolio
    @State private var showAlert = false
    
    init(portfolio: Portfolio) {
        self.portfolio = portfolio
        self._draft = State(initialValue: portfolio)
    }
    
    func deletePortfolio() {
        presentation.wrappedValue.dismiss()
        userData.deletePortfolio(portfolio)
    }
    
    func saveAndClose() {
        //  MARK: ПЕРЕНЕСТИ В МОДЕЛЬ!!!

        if let index = userData.portfolios.firstIndex(where: { $0.id == self.portfolio.id }) {
            userData.portfolios[index].name = draft.name
            userData.portfolios[index].broker = draft.broker
            userData.portfolios[index].note = draft.note
        }
        
        presentation.wrappedValue.dismiss()
    }
    
    var body: some View {
        
        return NavigationView {
            Form {
                Section(header: Text("Название".uppercased())) {
                    TextField("Название портфеля", text: $draft.name)
                        .foregroundColor(.systemOrange)
                }
                
                Section(header: Text("Брокер".uppercased())) {
                    TextField("Брокер", text: $draft.broker)
                        .foregroundColor(.systemOrange)
                }
                
                Section(header: Text("Комментарий/Примечание".uppercased())) {
                    TextField("Комментарий/Примечание", text: $draft.note)
                        .foregroundColor(.systemOrange)
                }
                
                Section(header: Text("TBD: список эмиссий".uppercased())) {
                    Text("TBD: список эмиссий в портфеле")
                }
                
                Section {
                    Button("Удалить портфель") {
                        self.showAlert = true
                    }
                    .foregroundColor(.systemRed)
                }
            }
                
            .navigationBarTitle("Портфель")
                
            .navigationBarItems(trailing: TrailingButton(name: "Закрыть") {
                self.saveAndClose()
            })
                
                .actionSheet(isPresented: $showAlert) {
                    ActionSheet(title: Text("Удалить портфель"),
                                message: Text("и все транзации с ним связанные?\nОтменить удаление невозможно."),
                                buttons: [
                                    .cancel(Text("Отмена")),
                                    .destructive(Text("Да, удалить портфель и транзакции")) {
                                        self.deletePortfolio()
                                    }
                    ])
            }
        }
    }
}

struct PortfolioDetail_Previews: PreviewProvider {
    static var previews: some View {
        let portfolio = Portfolio(name: "Optimus Prime", broker: "Winterfell Direct", comment: "Winter is coming…")
        
        return PortfolioDetail(portfolio: portfolio)
            
            .environmentObject(UserData())
            .environment(\.colorScheme, .dark)
    }
}

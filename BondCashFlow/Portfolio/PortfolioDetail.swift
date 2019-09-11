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
    
    @State private var showAlert = false
    
    func deletePortfolio() {
        presentation.wrappedValue.dismiss()
        userData.deletePortfolio(portfolio)
    }
    
    var body: some View {
        let index = userData.portfolios.firstIndex(where: { $0.id == self.portfolio.id })
        
        return NavigationView {
            Form {
                if index != nil {
                    Section(header: Text("Название".uppercased())) {
                        TextField("Название портфеля", text: $userData.portfolios[index!].name)
                    }
                    
                    Section(header: Text("Брокер".uppercased())) {
                        TextField("Брокер", text: $userData.portfolios[index!].broker)
                    }
                    
                    Section(header: Text("Комментарий/Примечание".uppercased())) {
                        TextField("Комментарий/Примечание", text: $userData.portfolios[index!].note)
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
            }
                
            .navigationBarTitle("Портфель")
                
            .navigationBarItems(trailing: TrailingButton(name: "Закрыть") {
                self.presentation.wrappedValue.dismiss()
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
        let portfolio = Portfolio(name: "Optimus Prime", broker: "Альфа Директ", comment: "Igor")
        
        return PortfolioDetail(portfolio: portfolio)
            
            .environmentObject(UserData())
            .environment(\.colorScheme, .dark)
    }
}

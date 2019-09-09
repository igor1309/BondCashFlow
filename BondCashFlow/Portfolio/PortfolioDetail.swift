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
    @Binding var portfolio: Portfolio
    @State var showConfirmation = false
    
    func deletePortfolio() {
        print("about to delete portfolio and transactions…")
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Название".uppercased())) {
                    TextField("Название портфеля", text: $portfolio.name)
                }
                
                Section(header: Text("Брокер".uppercased())) {
                    TextField("Брокер", text: $portfolio.broker)
                }
                
                Section(header: Text("Комментарий/Примечание".uppercased())) {
                    TextField("Комментарий/Примечание", text: $portfolio.note)
                }
                
                Section(header: Text("TBD: список эмиссий".uppercased())) {
                    Text("TBD: список эмиссий")
                }
                
                Section {
                    Button("Удалить портфель") {
                        self.showConfirmation = true
                    }
                    .foregroundColor(.systemRed)
                }
                    
                .navigationBarTitle("Портфель")
                    
                .navigationBarItems(trailing: TrailingButton(name: "Закрыть") {
                    self.presentation.wrappedValue.dismiss()
                })
                    
                    .actionSheet(isPresented: $showConfirmation) {
                        ActionSheet(title: Text("Удалить портфель?"),
                                    message: Text("Удалить портфель и все транзации с ним связанные?\nОтменить удаление невозможно."),
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
}

struct PortfolioDetail_Previews: PreviewProvider {
    static var previews: some View {
        let portfolio = Portfolio(name: "Optimus Prime", broker: "Альфа Директ", comment: "Igor")
        
        return PortfolioDetail(portfolio: .constant(portfolio))
            
            .environmentObject(UserData())
            .environment(\.colorScheme, .dark)
    }
}

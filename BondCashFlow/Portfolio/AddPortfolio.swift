//
//  AddPortfolio.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 24.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct PortfolioEditor: View {
    @Binding var portfolio: Portfolio
    var nameErrorNote: String
    
    var body: some View {
        Form {
            Section(header: Text("Портфель".uppercased()),
                    footer: EmptyView()) {
                        TextField("Название портфеля", text: $portfolio.name)
                        
                        if nameErrorNote.isNotEmpty {
                            Text(nameErrorNote).foregroundColor(.systemRed)
                        }
            }
            
            Section(header: Text("Брокер".uppercased())) {
                TextField("Брокер", text: $portfolio.broker)
            }
            
            Section(header: Text("Комментарий/Примечание".uppercased())) {
                TextField("Комментарий/Примечание", text: $portfolio.note)
            }
            
            Section(header: Text("TBD: список брокеров".uppercased())) {
                Text("TBD: список брокеров")
            }
            
            Section(header: Text("TBD: список эмиссий".uppercased())) {
                Text("TBD: список эмиссий")
            }
        }
    }
}


struct AddPortfolio: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var userData: UserData
    
    @Binding var portfolioName: String
    @State private var draft: Portfolio = Portfolio()
    
    private var nameErrorNote: String {
        if draft.name.isEmpty {
            return "Введите название портфеля"
        } else if userData.portfolios.map({ $0.name }).contains(draft.name) {
            return "Портфель с таким названием уже есть."
        } else {
            return ""
        }
    }
    
    private var draftPortfolioIsValid: Bool {
        draft.name.isNotEmpty && !userData.portfolios.map { $0.name }.contains(draft.name)
    }
    
    func savePortfolio() {
        if draftPortfolioIsValid { userData.portfolios.append(draft) }
    }
    
    var body: some View {
        NavigationView {
            
            PortfolioEditor(portfolio: $draft, nameErrorNote: nameErrorNote)
                
                .navigationBarTitle("Новый портфель")
                
                .navigationBarItems(
                    leading: LeadingButton(name: "Отмена", closure: {
                        self.presentation.wrappedValue.dismiss()
                    })
                        .foregroundColor(.systemRed),
                    
                    trailing: TrailingButton(name: "Сохранить") {
                        if self.draftPortfolioIsValid {
                            self.savePortfolio()
                            self.presentation.wrappedValue.dismiss()
                        }
                    }
                    .disabled(!draftPortfolioIsValid)
            )
        }
    }
}

struct AddPortfolio_Previews: PreviewProvider {
    static var previews: some View {
        AddPortfolio(portfolioName: .constant(""))
            .environmentObject(UserData())
    }
}

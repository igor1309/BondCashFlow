//
//  AddPortfolio.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 24.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct AddPortfolio: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var userData: UserData
    
    @State private var portfolioName = ""
    @State private var nameErrorNote = ""
    
    private func validatePortfolioName() {
        
        if self.portfolioName.isNotEmpty {
            self.nameErrorNote = ""
        } else {
            self.nameErrorNote = "Введите название портфеля"
        }
        
        //  MARK: - add actions and validations
        //  проверить на уникальность навания
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(footer: Text(nameErrorNote).foregroundColor(.systemRed)) {
                    TextField("Название", text: $portfolioName,
                              onEditingChanged: { _ in
                                //  MARK: - all additional validating actions
                                self.validatePortfolioName()},
                              onCommit: {
                                //  MARK: - all additional validating actions
                                self.validatePortfolioName()})
                }
            }
                
            .navigationBarTitle("Новый портфель")
                
            .navigationBarItems(
                leading: Button(action: {
                    self.presentation.wrappedValue.dismiss()
                }) {
                    Text("Cancel").foregroundColor(.systemRed)
                },
                
                trailing: Button(action: {
                    //  MARK: - add actions and validations
                    if self.nameErrorNote.isEmpty {
                        self.presentation.wrappedValue.dismiss()
                    }
                }) {
                    Text("Save")
            })
        }
    }
}

struct AddPortfolio_Previews: PreviewProvider {
    static var previews: some View {
        AddPortfolio()
        .environmentObject(UserData())
    }
}

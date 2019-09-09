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
    
    @Binding var portfolioName: String
    @State private var draftName: String
    
    init(portfolioName: Binding<String>) {
        self._portfolioName = portfolioName
        self._draftName = State(initialValue: portfolioName.wrappedValue)
    }
    
    private var nameErrorNote: String {
        if self.draftName.isEmpty {
            return "Введите название портфеля"
        } else if userData.portfolioNames.contains(draftName) {
            return "Портфель с таким названием уже есть."
        } else {
            return ""
        }
    }
    private var draftNameIsValid: Bool {
        draftName.isNotEmpty && !userData.portfolioNames.contains(draftName)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Портфель".uppercased()),
                        footer: Text(nameErrorNote).foregroundColor(.systemRed)) {
                    TextField("Название портфеля", text: $draftName)
                }
            }
                
            .navigationBarTitle("Новый портфель")
                
            .navigationBarItems(
                leading: LeadingButton(name: "Отмена", closure: {
                    self.presentation.wrappedValue.dismiss()
                })
                    .foregroundColor(.systemRed),
                
                trailing: Button(action: {
                    //  MARK: - add actions and validations
                    if self.draftNameIsValid {
//                        self.userData.portfolioNames.append(self.draftName)
                        self.portfolioName = self.draftName
                        self.presentation.wrappedValue.dismiss()
                    }
                }) {
                    Text("Сохранить")
                        .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 0))
            })
        }
    }
}

struct AddPortfolio_Previews: PreviewProvider {
    static var previews: some View {
        AddPortfolio(portfolioName: .constant(""))
            .environmentObject(UserData())
    }
}

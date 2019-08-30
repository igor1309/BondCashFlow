//
//  AddIssue.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 24.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct AddIssue: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var userData: UserData
    
    @State private var issuer = ""
    @State private var issuerErrorNote = ""
    @State private var isin = ""
    @State private var isinErrorNote = ""
    
    private func validateIssuer() {
        
        if self.issuer.isNotEmpty {
            self.issuerErrorNote = ""
        } else {
            self.issuerErrorNote = "Введите название портфеля"
        }
        
        //  MARK: - add actions and validations
        //  проверить на уникальность навания
    }
    
    private func validateISIN() {
        
        if self.issuer.isNotEmpty {
            self.issuerErrorNote = ""
        } else {
            self.issuerErrorNote = "Введите название портфеля"
        }
        
        //  MARK: - add actions and validations
        //  проверить на уникальность навания
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Эмитент".uppercased())) {
                    //  MARK: - а может брать эмитента из базы?
                    //  или и то и другое?
                    //  как проверять??
                    TextField("Название эмитента", text: $issuer,
                              onEditingChanged: { _ in
                                //  MARK: - all additional validating actions
                                self.validateIssuer()},
                              onCommit: {
                                //  MARK: - all additional validating actions
                                self.validateIssuer()})
                    
                    Picker(selection: /*@START_MENU_TOKEN@*/.constant(1)/*@END_MENU_TOKEN@*/, label: Text("Эмитент")) {
                        /*@START_MENU_TOKEN@*/Text("1").tag(1)/*@END_MENU_TOKEN@*/
                        /*@START_MENU_TOKEN@*/Text("2").tag(2)/*@END_MENU_TOKEN@*/
                    }
                }
                
                Section(header: Text("Код выпуска (ISIN)".uppercased())) {
                    TextField("Код выпуска (ISIN)", text: $isin,
                              onEditingChanged: { _ in
                                //  MARK: - all additional validating actions
                                self.validateISIN()},
                              onCommit: {
                                //  MARK: - all additional validating actions
                                self.validateISIN()})
                    
                    Picker(selection: /*@START_MENU_TOKEN@*/.constant(1)/*@END_MENU_TOKEN@*/, label: Text("Код выпуска (ISIN)")) {
                        /*@START_MENU_TOKEN@*/Text("1").tag(1)/*@END_MENU_TOKEN@*/
                        /*@START_MENU_TOKEN@*/Text("2").tag(2)/*@END_MENU_TOKEN@*/
                    }
                }
            }
                
            .navigationBarTitle("Добавить выпуск")
                
            .navigationBarItems(
                leading: Button(action: {
                    self.presentation.wrappedValue.dismiss()
                }) {
                    Text("Cancel").foregroundColor(.systemRed)
                },
                
                trailing: Button(action: {
                    //  MARK: - add actions and validations
                    //  проверить есть ли выпуск в базе
                    //  если нет, уточнить, нужно ли его добавлять
                    if self.issuerErrorNote.isEmpty && self.isinErrorNote.isEmpty {
                        self.presentation.wrappedValue.dismiss()
                    }
                }) {
                    Text("Save")
            })
            
        }
    }
}

struct AddIssue_Previews: PreviewProvider {
    static var previews: some View {
        AddIssue()
            .environmentObject(UserData())
    }
}

//
//  CbondLogin.swift
//  BondsCashFlow
//
//  Created by Igor Malyarov on 25.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct CbondLogin: View {
    @Environment(\.presentationMode) var presentation
    
    @Binding var login: String
    @Binding var password: String
    var footer: String {
        (login.isNotEmpty && password.isNotEmpty) ? "" : "Логин-пароль не могут быть пустыми"
    }
    //  MARK: - TODO: prevent dismiss by swipe with empty fields
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Логин-пароль к cbonds.ru".uppercased()),
                        footer: Text(footer).foregroundColor(.systemRed)
                ){
                    TextField("Логин", text: $login)
                    TextField("Пароль", text: $password)
                }
                
                Section(header: Text("Доступ к cbonds.ru".uppercased())
                ){
                    if !(login == "test" && password == "test") {
                        Button(action: {
                            self.login = "test"
                            self.password = "test"
                        }) {
                            Text("Тестовый доступ")
                        }
                    }
                    
                    if !(login == "igor@rbiz.group" && password == "bonmaM-wojhed-fokza3") {
                        Button(action: {
                            self.login = "igor@rbiz.group"
                            self.password = "bonmaM-wojhed-fokza3"
                            
                        }) {
                            Text("igor@rbiz.group")
                        }
                    }
                }
            }
            .navigationBarTitle("Логин-пароль")
                
            .navigationBarItems(trailing: Button(action: {
                //  MARK: - add actions
                self.presentation.wrappedValue.dismiss()
            }) {
                Text("Закрыть")
                    .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 0))
            })
        }
        
    }
}

struct CbondLogin_Previews: PreviewProvider {
    static var previews: some View {
        CbondLogin(login: .constant("test"),
                   password: .constant("test"))
    }
}

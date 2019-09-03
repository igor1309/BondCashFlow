//
//  CbondLogin.swift
//  BondsCashFlow
//
//  Created by Igor Malyarov on 25.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

//  MARK: TODO: change to userdata

//  MARK: TODO: use hash to store password
//  MARK: TODO: prevent dismiss by swipe with empty fields

struct CbondLogin: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var settings: SettingsStore
    
    var footer: String {
        (settings.login.isNotEmpty && settings.password.isNotEmpty) ? "" : "Логин-пароль не могут быть пустыми"
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Логин-пароль к cbonds.ru".uppercased()),
                        footer: Text(footer).foregroundColor(.systemRed)
                ){
                    TextField("Логин", text: $settings.login)
                    TextField("Пароль", text: $settings.password)
                }
                
                Section(header: Text("Доступ к cbonds.ru".uppercased())
                ){
                    if !(settings.login == "test" && settings.password == "test") {
                        Button(action: {
                            self.settings.login = "test"
                            self.settings.password = "test"
                        }) {
                            Text("Тестовый доступ")
                        }
                    }
                    
                    if !(settings.login == "igor@rbiz.group" && settings.password == "bonmaM-wojhed-fokza3") {
                        Button(action: {
                            self.settings.login = "igor@rbiz.group"
                            self.settings.password = "bonmaM-wojhed-fokza3"
                            
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
        CbondLogin()
    }
}

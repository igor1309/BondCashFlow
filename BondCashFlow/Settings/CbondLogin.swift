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
                Section(header: Text("Доступ к cbonds.ru".uppercased()),
                        footer: Text(footer).foregroundColor(.systemRed)
                ){
                    TextField("Логин", text: $settings.login)
                    TextField("Пароль", text: $settings.password)
                    
                    if !(settings.isTestLogin) {
                        Button(action: {
                            self.settings.loginTest()
                        }) {
                            Text("Тестовый доступ")
                        }
                    }
                    
                    if !(settings.isIgorLogin) {
                        Button(action: {
                            self.settings.loginIgor()
                            
                        }) {
                            Text("igor@rbiz.group")
                        }
                    }
                }
                
                Section(header: Text("Параметры запроса".uppercased()),
                        footer: Text("Лимит: 1000 записей")) {
                    
                    CbondOperationPicker(cbondOperation: $settings.lastCBondOperationUsed)
                    
                    CbondLimitPicker(cbondLimit: $settings.lastCBondLimitUsed)
                    
                    CbondOffsetPicker(cbondOffset: $settings.lastCBondOffsetUsed)
                }
            }
            .navigationBarTitle("Параметры")
                
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
            .environmentObject(SettingsStore())
    }
}

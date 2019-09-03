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
    @EnvironmentObject var userData: UserData
    
    var footer: String {
        (userData.login.isNotEmpty && userData.password.isNotEmpty) ? "" : "Логин-пароль не могут быть пустыми"
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Логин-пароль к cbonds.ru".uppercased()),
                        footer: Text(footer).foregroundColor(.systemRed)
                ){
                    TextField("Логин", text: $userData.login)
                    TextField("Пароль", text: $userData.password)
                }
                
                Section(header: Text("Доступ к cbonds.ru".uppercased())
                ){
                    if !(userData.login == "test" && userData.password == "test") {
                        Button(action: {
                            self.userData.login = "test"
                            self.userData.password = "test"
                        }) {
                            Text("Тестовый доступ")
                        }
                    }
                    
                    if !(userData.login == "igor@rbiz.group" && userData.password == "bonmaM-wojhed-fokza3") {
                        Button(action: {
                            self.userData.login = "igor@rbiz.group"
                            self.userData.password = "bonmaM-wojhed-fokza3"
                            
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

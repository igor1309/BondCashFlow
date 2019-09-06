//
//  CBondsSection.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 02.09.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct CBondsSection: View {
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var settings: SettingsStore
    @State private var showModal = false
    
    var body: some View {
        Section(header: Text("Запросить cbonds.ru".uppercased()),
                footer: Text("Объем доступной информации cbonds.ru зависит от доступа (логин:пароль). Обновить можно все справочники или выбранные (Эмиссии или Потоки).")
        ){
            HStack {
                Button("Параметры доступа") {
                    self.showModal = true
                }
                
                Spacer()
                
                Image(systemName: "pencil.and.ellipsis.rectangle")
                    .foregroundColor(.secondary)
                    .contextMenu {
                        Button(action: {
                            self.settings.loginTest()
                        }) {
                            HStack {
                                Image(systemName: "person.circle.fill")
                                Spacer()
                                Text("тестовый доступ")
                            }
                        }
                        Button(action: {
                            self.settings.loginIgor()
                        }) {
                            HStack {
                                Image(systemName: "person.crop.circle.badge.checkmark")
                                Spacer()
                                Text("igor@rbiz.group")
                            }
                        }
                }
            }
            
            UpdateLocalDataSection()
        }
            
        .sheet(isPresented: $showModal,
               content: {
                CbondLogin()
                    .environmentObject(self.userData)
                    .environmentObject(self.settings)
        })
    }
}

struct CBondsSection_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Form {
                CBondsSection()
                    .environmentObject(UserData())
            }
        }
    }
}

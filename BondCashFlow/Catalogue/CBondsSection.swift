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
                footer: Text("Объем доступной информации cbonds.ru зависит от доступа (логин:пароль).\nTDB: Обновить можно все справочники или выбранные (Эмиссии или Потоки).")
        ){
            HStack {
                Text("Логин-пароль")
                
                Spacer()
                
                Text("\(settings.login):\(settings.password)")
            }
            .foregroundColor(.accentColor)
            .onTapGesture {
                self.showModal = true
            }
            
            CbondOperationPicker(cbondOperation: $settings.lastCBondOperationUsed)
            
            CbondLimitPicker(cbondLimit: $settings.lastCBondLimitUsed)
            
            CbondOffsetPicker(cbondOffset: $settings.lastCBondOffsetUsed)
            
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

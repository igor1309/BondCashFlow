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
    @State private var showModal = false
    
    var body: some View {
        Section(header: Text("Запросить cbonds.ru".uppercased()),
                footer: Text("Объем доступной информации cbonds.ru зависит от доступа (логин:пароль).\nTDB: Обновить можно все справочники или выбранные (Эмиссии или Потоки) или только изранные и по выпускам в портфелях.")
        ){
            HStack {
                Text("Логин-пароль")
                
                Spacer()
                
                Text("\(userData.login):\(userData.password)")
            }
            .foregroundColor(.accentColor)
            .onTapGesture {
                self.showModal = true
            }
            
            CbondOperationPicker(cbondOperation: $userData.lastCBondOperationUsed)
            //                .environmentObject(self.userData)
            
            CbondLimitPicker(cbondLimit: $userData.lastCBondLimitUsed)
            //                .environmentObject(self.userData)
            
            CbondOffsetPicker(cbondOffset: $userData.lastCBondOffsetUsed)
            //                .environmentObject(self.userData)
            
            UpdateLocalDataSection()
        }
            
        .sheet(isPresented: $showModal,
               content: {
                CbondLogin()
                    .environmentObject(self.userData)
                
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

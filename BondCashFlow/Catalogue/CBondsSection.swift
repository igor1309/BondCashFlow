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
    
    @State private var login: String = "test"
    @State private var password: String = "test"
    @State private var showModal = false
    
//    @State private var cbondOperation: String = userData.lastCBondOperationUsed // = "get_emissions"//"get_flow"  // get_emissions
        
//    @State private var cbondLimit = 100
    @State private var cbondOffset = 0
    
    var body: some View {
        Section(header: Text("cbonds.ru".uppercased()),
                footer: Text("Можно обновить все справочники или выбранные (Эмиссии или Потоки) или только по выпускам в портфелях.")
        ){
            HStack {
                HStack {
                    Text("Логин-пароль")
                    
                    //                        Image(systemName: "pencil.and.ellipsis.rectangle")
                }
                
                Spacer()
                
                Text("\(login):\(password)")
            }
            .foregroundColor(.accentColor)
            .onTapGesture {
                //                self.modal = .credentials
                self.showModal = true
            }
            
            CbondOperationPicker(cbondOperation: $userData.lastCBondOperationUsed)
            
            CbondLimitPicker(cbondLimit: $userData.lastCBondLimitUsed)
            
            CbondOffsetPicker(cbondOffset: $cbondOffset)
            
            UpdateLocalDataSection(login: login, password: password, cbondOperation: userData.lastCBondOperationUsed, cbondLimit: userData.lastCBondLimitUsed, cbondOffset: cbondOffset)
        }
            
        .sheet(isPresented: $showModal,
               
               //  MARK: TODO: change to userdata
            
            //  MARK: TODO: use hash to store password
            //  MARK: TODO: prevent dismiss by swipe with empty fields
            content: {
                CbondLogin(login: self.$login, password: self.$password)
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

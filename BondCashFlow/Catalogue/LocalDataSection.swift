//
//  LocalDataSection.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 02.09.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct LocalDataSection: View {
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var settings: SettingsStore
    @State private var showModal = false
    
    var body: some View {
        Section(header: Text("Локальная база".uppercased())
        ){
            Group {
                LocalStoreInfo()
                
                FlowsMetadata()
                
                
                EmissionsMetadata()
            }
            .foregroundColor(.secondary)
            .font(.footnote)
            
            Button(action: {
                self.showModal = true
            }) {
                Text("Показать выпуски")
            }
        }
            
        .sheet(isPresented: $showModal, content: {
            EmissionList()
                .environmentObject(self.userData)
                .environmentObject(self.settings)
        })
    }
}

struct LocalDataSection_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Form {
                LocalDataSection()
                    .environmentObject(UserData())
            }
        }
    }
}

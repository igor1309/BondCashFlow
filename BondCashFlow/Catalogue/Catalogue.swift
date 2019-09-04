//
//  Catalogue.swift
//  BondsCashFlow
//
//  Created by Igor Malyarov on 25.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI


struct Catalogue: View {
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var settings: SettingsStore
    
    var body: some View {
        Form {
            LocalDataSection()
//                .environmentObject(self.settings)
            
            CBondsSection()
                .environmentObject(self.userData)
        }
        .navigationBarTitle("Справочники")
    }
}

struct Catalogue_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Catalogue()
                .environmentObject(UserData())
                .environmentObject(SettingsStore())
        }
    }
}

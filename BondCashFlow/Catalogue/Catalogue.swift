//
//  Catalogue.swift
//  BondsCashFlow
//
//  Created by Igor Malyarov on 25.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI


struct Catalogue: View {
    var body: some View {
        Form {
            LocalDataSection()
            
            CBondsSection()
        }
        .navigationBarTitle("Справочники")
    }
}

struct Catalogue_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Catalogue()
                .environmentObject(UserData())
        }
    }
}

//
//  Settings.swift
//  BondsCashFlow
//
//  Created by Igor Malyarov on 25.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct Settings: View {
    var body: some View {
        Text("Настройки")
            
            .navigationBarTitle("Настройки")
        
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Settings()
        }
    }
}

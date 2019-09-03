//
//  ShowEmissionListButton.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 03.09.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct ShowEmissionListButton: View {
    @EnvironmentObject var userData: UserData
    @State private var showModal = false
    
    var body: some View {
        Button(action: {
            self.showModal = true
        }) {
            Text("Показать выпуски")
        }
            
        .sheet(isPresented: $showModal,
               content: {
                EmissionList(local: true)
                    .environmentObject(self.userData)
        })
    }
}

struct ShowEmissionListButton_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Form {
                ShowEmissionListButton()
                    .environmentObject(UserData())
            }
        }
    }
}

//
//  EmissionDetail2.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 04.09.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct FlowsList: View {
    var flows: [Flow]
    
    var body: some View {
        List {
            ForEach(flows, id: \.self) { flow in
                FlowRow(flow: flow)
            }
        }
    }
}


struct EmissionDetail2: View {
    @EnvironmentObject var userData: UserData
    @Environment(\.presentationMode) var presentation
    var emission: Emission
    
    var body: some View {
        NavigationView {
            VStack {
                Text(/*@START_MENU_TOKEN@*/"Hello World!"/*@END_MENU_TOKEN@*/)
                
                FlowsList(flows: userData.flows
                    .filter({ $0.emissionID == emission.id })
                    .sorted(by: { $0.couponNum < $1.couponNum }))
            }
            
            .navigationBarTitle("Выпуск и потоки")
                
            .navigationBarItems(trailing: TrailingButton(name: "Закрыть", closure: {
                self.presentation.wrappedValue.dismiss()
            }))
        }
    }
}

struct EmissionDetail2_Previews: PreviewProvider {
    static var previews: some View {
        EmissionDetail2(emission: Emission())
        .environmentObject(UserData())
        .environmentObject(SettingsStore())
    }
}

//
//  PositionsByEmissionList.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 10.09.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct PositionsByEmissionList: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        List {
            ForEach(userData.positions
                .map { $0.emissionID }
                .removingDuplicates()
                .sorted(), id: \.self) { emissionID in
                    
                    PositionForEmission(emissionID: emissionID)
            }
        }
            
        .navigationBarTitle("Выпуски в портфелях", displayMode: .inline)
            
        .navigationBarItems(trailing:
            TrailingButton(name: "Закрыть") {
                self.presentation.wrappedValue.dismiss()
            }
        )
    }
}


struct PositionsByEmissionList_Previews: PreviewProvider {
    static var previews: some View {
        PositionsByEmissionList()
    }
}

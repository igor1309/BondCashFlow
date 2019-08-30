//
//  CashFlowTimeline.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 23.07.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct CashFlowTimeline: View {
    @EnvironmentObject private var userData: UserData
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                CashFlowGrid()
                    .environmentObject(self.userData)
                    .padding()
            }
        }
    }
}

#if DEBUG
struct CashFlowTimeline_Previews: PreviewProvider {
    static var previews: some View {
        CashFlowTimeline()
            .environmentObject(UserData())
    }
}
#endif

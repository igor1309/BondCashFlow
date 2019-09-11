//
//  FlowsList.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 04.09.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct FlowsList: View {
    var flows: [Flow]
    var qty: Int
    
    var body: some View {
        List {
            ForEach(flows, id: \.self) { flow in
                FlowRow(flow: flow, qty: self.qty)
            }
        }
    }
}

struct FlowsList_Previews: PreviewProvider {
    static var previews: some View {
        FlowsList(flows: [], qty: 1)
    }
}

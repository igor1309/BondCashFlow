//
//  FlowsList.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 04.09.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

//  MARK: TODO: redemption!!!!!!!
struct FlowRow2: View {
    var flow: Flow
    var qty: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text(flow.date.toString())
                
                Spacer()
                
                Text((Double(qty) * flow.cuponSum).formattedGrouped) // (Double(qty) * flow).cuponSum.formattedGrouped
            }
            
            Group {
                HStack {
                    Text("Купон №" + flow.couponNum.formattedGrouped)
                    
                    Spacer()
                    
                    Text("Сумма: " + flow.cuponSum.formattedGrouped)
                    
                }
                
                Text("Ставка купона: " + flow.cuponRate.formattedPercentageWithDecimals)
            }
            .font(.footnote)
            .foregroundColor(.secondary)
        }
    }
}


struct FlowsList: View {
    var flows: [Flow]
    var qty: Int
    
    var body: some View {
        List {
            ForEach(flows, id: \.self) { flow in
                FlowRow2(flow: flow, qty: self.qty)
            }
        }
    }
}

struct FlowsList_Previews: PreviewProvider {
    static var previews: some View {
        FlowsList(flows: [], qty: 1)
    }
}

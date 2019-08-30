//
//  FlowRow.swift
//  BondsCashFlow
//
//  Created by Igor Malyarov on 27.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct FlowRow: View {
    var flow: CashFlowStructure
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Купон №" + flow.couponNum.formattedGrouped)
            Group {
                HStack {
                    Text("Ставка купона: " + flow.cuponRate.formattedPercentageWithDecimals)
                    
                    Spacer()
                    
                    Text("Сумма: " + flow.cuponSum.formattedGrouped)
                }
                if flow.daysBeetwenCoupons != -1 {
                    Text("Дней между купонами: " + flow.daysBeetwenCoupons.formattedGrouped)
                }
                Text("date: " + flow.date.toString())
                Text("cuponRateDate: " + flow.cuponRateDate.toString())
            }
            .font(.subheadline)
            .foregroundColor(.secondary)
        }
    }
}

struct FlowRow_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                FlowRow(flow: CashFlowStructure())
                FlowRow(flow: CashFlowStructure())
                FlowRow(flow: CashFlowStructure())
                FlowRow(flow: CashFlowStructure())
            }
        .navigationBarTitle("Купоны")
        }
    }
}

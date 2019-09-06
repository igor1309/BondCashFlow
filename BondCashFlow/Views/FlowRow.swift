//
//  FlowRow.swift
//  BondsCashFlow
//
//  Created by Igor Malyarov on 27.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct FlowRow: View {
    var flow: Flow
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            HStack(alignment: .firstTextBaseline) {
                Text("Купон №" + flow.couponNum.formattedGrouped)
                
                Spacer()
                
                Text("Сумма:")
                    .foregroundColor(.secondary)
                    .font(.footnote)

                Text(flow.cuponSum == -1 ? "#н/д" : flow.cuponSum.formattedGrouped)
                    .fontWeight(.light)
            }
            
            HStack(alignment: .firstTextBaseline) {
                Text(flow.date.toString())
                    .foregroundColor(.systemOrange)
                    .fontWeight(.light)
                
                Text("(date)")
                    .foregroundColor(.secondary)
                    .font(.footnote)
                
                Spacer()
                
                Text("Ставка купона:")
                    .foregroundColor(.secondary)
                    .font(.footnote)

                Text(flow.cuponRate == -1 ? "#н/д" : flow.cuponRate.formattedPercentageWithDecimals)
                    .foregroundColor(.systemOrange)
            }
            
            Group {
                if flow.daysBeetwenCoupons != -1 {
                    Text("Дней между купонами: " + (flow.daysBeetwenCoupons == 0 ? "#н/д" : flow.daysBeetwenCoupons.formattedGrouped))
                }
                
                Text("cuponRateDate: " + (flow.cuponRateDate == .distantPast ? "#н/д" : flow.cuponRateDate.toString()))
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
                FlowRow(flow: Flow())
                FlowRow(flow: Flow())
                FlowRow(flow: Flow())
                FlowRow(flow: Flow())
            }
            .navigationBarTitle("Купоны")
        }
        .environment(\.colorScheme, .dark)
    }
}

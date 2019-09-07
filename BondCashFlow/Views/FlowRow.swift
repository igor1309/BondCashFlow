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
    var qty: Int = 1
    
    var body: some View {
        Row(title: "Купон #" + flow.couponNum.formattedGrouped,
            detail: flow.cuponSum == -1 ? "#н/д" : (Double(qty) * flow.cuponSum).formattedGrouped,
            detailExtra: "Сумма: ",
            title2: flow.date.toString(),
            detail2: flow.cuponRate == -1 ? "#н/д" : flow.cuponRate.formattedPercentageWithDecimals,
            subtitle: flow.daysBeetwenCoupons == -1 ? "#н/д" : "Дней между купонами: " + flow.daysBeetwenCoupons.formattedGrouped,
            subdetail: (flow.cuponRateDate == .distantPast ? "#н/д" : flow.cuponRateDate.toString()),
            extraline: "cuponRateDate: " + (flow.cuponRateDate == .distantPast ? "#н/д" : flow.cuponRateDate.toString()))
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

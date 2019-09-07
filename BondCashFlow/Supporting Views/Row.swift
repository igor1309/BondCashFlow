//
//  Row.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 08.09.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct Row: View {
    var topline: String
    var title: String
    var detail: String
    var detailExtra: String = ""
    var title2: String = ""
    var detail2: String = ""
    var subtitle: String
    var subdetail: String
    var extraline: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            
            if topline.isNotEmpty {
                Text(topline)
                    .font(.caption)
                    .fontWeight(.light)
                    .foregroundColor(.systemOrange)
            }
            
            HStack(alignment: .firstTextBaseline) {
                Text(title)
                    .fixedSize(horizontal: false, vertical: true)
                
                Spacer()
                
                Text(detailExtra)
                .foregroundColor(.secondary)
                .font(.footnote)
                
                Text(detail)
                    .foregroundColor(.systemOrange)
            }
            
            if title2.isNotEmpty {
                HStack(alignment: .firstTextBaseline) {
                    Text(title2)
                        .foregroundColor(.systemOrange)
                    
                    Spacer()
                    
                    Text(detail2)
                }
                .font(.subheadline)
            }
            
            HStack(alignment: .firstTextBaseline) {
                Text(subtitle)
                
                Spacer()
                
                Text(subdetail.uppercased())
                //                    .fontWeight(.thin)
                //                    .foregroundColor(.systemOrange)
            }
            .font(.subheadline)
            .foregroundColor(.secondary)
            
            if extraline.isNotEmpty {
                Text(extraline)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }
}

struct Row_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                Row(topline: "Megatron", title: "Альфа-Банк, ПО-3459, Jun 2020", detail: 123456.formattedGrouped, subtitle: "id: 6354 ISIN: KHF85955GHJ", subdetail: "Купон", extraline: "купонная ставка опредяляется эмитентом, исходя из…")
                Row(topline: "", title: "Альфа-Банк, ПО-3459, Jun 2020", detail: 123456.formattedGrouped, detailExtra: "Сумма: ", title2: "Купонная ставка", detail2: "12%", subtitle: "id: 6354 ISIN: KHF85955GHJ", subdetail: "Купон", extraline: "купонная ставка опредяляется эмитентом, исходя из…")
                Row(topline: "Megatron", title: "Альфа-Банк, ПО-3459, Jun 2020", detail: 123456.formattedGrouped, subtitle: "id: 6354 ISIN: KHF85955GHJ", subdetail: "Купон")
                Row(topline: "Megatron", title: "Альфа-Банк, ПО-3459, Jun 2020", detail: 123456.formattedGrouped, subtitle: "id: 6354 ISIN: KHF85955GHJ", subdetail: "Купон", extraline: "купонная ставка опредяляется эмитентом, исходя из…")
                Row(topline: "Megatron", title: "Альфа-Банк, ПО-3459, Jun 2020", detail: 123456.formattedGrouped, subtitle: "id: 6354 ISIN: KHF85955GHJ", subdetail: "Купон")
                Row(topline: "Megatron", title: "Альфа-Банк, ПО-3459, Jun 2020", detail: 123456.formattedGrouped, subtitle: "id: 6354 ISIN: KHF85955GHJ", subdetail: "Купон", extraline: "купонная ставка опредяляется эмитентом, исходя из…")
            }
            .navigationBarTitle("Список")
        }
        .environment(\.colorScheme, .dark)
    }
}

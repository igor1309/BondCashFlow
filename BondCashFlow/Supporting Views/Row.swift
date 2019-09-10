//
//  Row.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 08.09.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

/// Universal `reusable Row` component (already used in Positions and Flows lists).
/// Consists of `3 to 5 styled rows`.
/// Top and bottom lines (both optional) consist of one element.
/// Three rows in center (the middle one also optiona) consist of two elements (title-detail).
/// Main row (title-detail) has optional element `detailExtra` to clarify detail meaning.
struct Row: View {
    var topline: String = ""
    var title: String
    var detail: String
    var detailExtra: String = ""
    var title2: String = ""
    var detail2: String = ""
    var detailExtra2: String = ""
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
                .font(.caption2)
                
                Text(detail)
                    .foregroundColor(.systemOrange)
            }
            
            if title2.isNotEmpty {
                HStack(alignment: .firstTextBaseline) {
                    Text(title2)
                        .foregroundColor(.systemOrange)
                    
                    Spacer()
                    
                    Text(detailExtra2)
                    .foregroundColor(.secondary)
                    .font(.caption2)
                    
                    Text(detail2)
                }
                .font(.subheadline)
            }
            
            HStack(alignment: .firstTextBaseline) {
                Text(subtitle)
                .fixedSize(horizontal: false, vertical: true)
                
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
                Row(topline: "", title: "Альфа-Банк, ПО-3459, Jun 2020", detail: 123456.formattedGrouped, detailExtra: "Сумма: ", title2: "Купонная ставка", detail2: "12%", subtitle: "id: 6354 ISIN: KHF85955GHJ", subdetail: "Купон", extraline: "купонная ставка опредяляется эмитентом, исходя из - и так далее")
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

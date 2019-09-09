//
//  Row2.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 09.09.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct Row2SubLeading: View {
    var title: String
    var title2: String
    var subtitle: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.title2)
                .fontWeight(.light)
                .fixedSize(horizontal: false, vertical: true)
            
            Text(title2)
                .font(.headline)
                .fontWeight(.light)
                .fixedSize(horizontal: false, vertical: true)
            Text(subtitle)
                .font(.footnote)
                .foregroundColor(.tertiary)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}

struct Row2SubTrailing: View {
    var detail: String
    var detailExtra: String
    var detail2: String
    var detailExtra2: String
    var subdetail: String
    var extraline: String

    var body: some View {
        VStack(alignment: .trailing, spacing: 0) {
            Text(detail)
                .font(.title2)
                .foregroundColor(.systemOrange)
                .opacity(detail == "#н/д" ? 0.4 : 1)
                        
            Text(detailExtra)
                .foregroundColor(.secondary)
                .font(.caption2)
            
            Text(detail2)
                .font(.title2)
                .fontWeight(.light)
                .foregroundColor(.secondary)
            
            Text(detailExtra2)
                .foregroundColor(.secondary)
                .font(.caption2)
            
            Text(subdetail.uppercased())
                .font(.subheadline)
                .fontWeight(.light)
                .foregroundColor(.systemOrange)
            
            Text(extraline)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .fixedSize(horizontal: false, vertical: true)
            
            Text("ближайший поток")
                .foregroundColor(.secondary)
                .font(.caption2)
            
        }
    }
}



struct Row2: View {
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
            Text(topline.uppercased())
                .font(.footnote)
//                .fontWeight(.light)
                .foregroundColor(.systemOrange)
            
            HStack(alignment: .top) {
                Row2SubLeading(title: title, title2: title2, subtitle: subtitle)
                    .layoutPriority(9)
                
                Spacer()
                
                Row2SubTrailing(detail: detail, detailExtra: detailExtra, detail2: detail2, detailExtra2: detailExtra2, subdetail: subdetail, extraline: extraline)
                .layoutPriority(9)
            }
        }
    }
}

struct Row2_Previews: PreviewProvider {
    let portfolio = Portfolio(name: "Optimus Prime", broker: "Альфа Директ", comment: "Igor")
    static var previews: some View {
        NavigationView {
            List {
                Row(topline: "Megatron", title: "Альфа-Банк, ПО-3459, Jun 2020", detail: 123456.formattedGrouped, subtitle: "id: 6354 ISIN: KHF85955GHJ", subdetail: "Купон", extraline: "купонная ставка опредяляется эмитентом, исходя из…")
            }
            .navigationBarTitle("Список")
        }
        .environment(\.colorScheme, .dark)
    }
}

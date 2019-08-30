//
//  TableInCell.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 24.07.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

// ТАБЛИЦА, НО КРИВО ((
// Answer by kontiki for How to use GeometryReader to achieve a table like layout?
// https://stackoverflow.com/questions/57152178/how-to-use-geometryreader-to-achieve-a-table-like-layout/57153811#57153811

struct TableInCell: View {
    var instrument: String
    var date: Date
    var type: CashFlowType
    var amount: Double
    
    var body: some View {
        GeometryReader { proxy in
            HStack(spacing: 0) {
                Text(self.instrument.uppercased())
                    .fontWeight(.light)
                    .font(.footnote)
                    .frame(width: proxy.size.width * 0.25, alignment: .leading)
                    .fixedSize()
                
                Text(self.date.toString())
                    .foregroundColor(.secondary)
                    .font(.caption)
                    .frame(width: proxy.size.width * 0.25, alignment: .center)
                    .fixedSize()
                
                Text(self.type.id)
                    .foregroundColor(.systemOrange)
                    .fontWeight(.light)
                    .font(.caption)
                    .frame(width: proxy.size.width * 0.25, alignment: .center)
                    .fixedSize()
                
                // MARK:- добавить форматирование
                // https://stackoverflow.com/questions/44630702/formatting-numbers-in-swift-3
                Text(String(self.amount))
                    .fontWeight(.light)
                    .font(.footnote)
                    .frame(width: proxy.size.width * 0.25, alignment: .trailing)
                    .fixedSize()
            }
        }
        .padding(.vertical)
            .padding(.vertical, 6)
    }
}

#if DEBUG
struct TableInCell_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            VStack {
                TableInCell(instrument: "Локс-2387546", date: Date().addWeeks(6).firstDayOfWeekRU.addDays(3), type: .face, amount: 1000000)
                TableInCell(instrument: "Локс-2387546", date: Date().addWeeks(6).firstDayOfWeekRU.addDays(3), type: .face, amount: 1000000)
                Spacer()
            }
            
            VStack {
                TableInCell(instrument: "Локс-2387546", date: Date().addWeeks(6).firstDayOfWeekRU.addDays(3), type: .face, amount: 1000000)
                TableInCell(instrument: "Локс-2387546", date: Date().addWeeks(6).firstDayOfWeekRU.addDays(3), type: .face, amount: 1000000)
                Spacer()
            }
            .preferredColorScheme(.dark)
        }
            .padding()
        .previewLayout(.sizeThatFits)
    }
}
#endif

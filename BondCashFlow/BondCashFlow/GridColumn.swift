//
//  GridColumn.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 22.07.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct GridColumn: View {
    @Binding var activeWeek: Int
    var weekNo: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(weekNo % 5 == 1 ? String(weekNo) : " ")
                .font(.caption)
                .foregroundColor(.secondary)
            GridItem(itemState: .full)  // MARK: NEED DATA
            GridItem(itemState: .empty) // MARK: NEED DATA
            GridItem(itemState: .full)  // MARK: NEED DATA
            GridItem(itemState: .empty) // MARK: NEED DATA
            GridItem(itemState: .empty) // MARK: NEED DATA
            GridItem(itemState: .gray)  //  fixed: Saturday, no need in data
            GridItem(itemState: .gray)  //  fixed: Sunday, no need in data
            GridItem(itemState: .none)  //  fixed: empty to space active week shevron, no need in data
        }
        .onTapGesture { self.activeWeek = self.weekNo }
            .modifier(Highlighter(show: activeWeek == weekNo))
        // .background(WeekBorder(show: activeWeek == weekNo))
    }
}

struct Highlighter: ViewModifier {
    let show: Bool
    
    func body(content: Content) -> some View {
        content
            .contrast(show ? 1 : 0.4)
            .overlay(
                Image(systemName: "chevron.compact.up")
                    .offset(y: show ? 60 : -1000)
                    .foregroundColor(.systemOrange))
    }
}

//struct WeekBorder: View {
//    let show: Bool
//    
//    var body: some View {
//        Capsule()
//            .fill(Color.clear)
//            .border(show ? Color.red : Color.clear, width: 2.0, cornerRadius: 15)
//            .animation(.easeIn(duration: 0.6))
//    }
//}
#if DEBUG
struct GridColumn_Previews: PreviewProvider {
    static var previews: some View {
        GridColumn(activeWeek: .constant(3), weekNo: 1)
    }
}
#endif

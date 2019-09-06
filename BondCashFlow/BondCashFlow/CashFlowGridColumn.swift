//
//  CashFlowGridColumn.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 23.07.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct CashFlowGridColumn: View {
    @EnvironmentObject var userData: UserData
    @State private var header = " "
    @Binding var activeWeek: Int
    var cashFlows: [CalendarCashFlow]
    var weekNo: Int
    var weekStartDate: Date
    
    private func cashFlowItemState(for date: Date) -> ItemState {
        if date.isWeekend {
            return .gray
        }
        
        if cashFlows.first(where: { Calendar.current.isDate($0.date, inSameDayAs: date) }) == nil {
            return .empty
        } else {
            return .full
        }
    }
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 3) {
            Text(weekNo % 5 == 0 ? String("W\(weekNo)") : " ")
                .font(.caption)
                .fontWeight(.thin)
            
            //  MARK: HIDE NEXT 3 LINES и последний CashFlowGridItem
            //            Text(self.activeWeek == self.weekNo ? self.header : " ")
            //                .font(.caption)
            //                .fontWeight(.thin)
            //                .frame(width: 40).fixedSize()
            //                .foregroundColor(.secondary)
            Group {
                CashFlowGridItem(itemState: cashFlowItemState(for: weekStartDate.addDays(0)))
                CashFlowGridItem(itemState: cashFlowItemState(for: weekStartDate.addDays(1)))
                CashFlowGridItem(itemState: cashFlowItemState(for: weekStartDate.addDays(2)))
                CashFlowGridItem(itemState: cashFlowItemState(for: weekStartDate.addDays(3)))
                CashFlowGridItem(itemState: cashFlowItemState(for: weekStartDate.addDays(4)))
                CashFlowGridItem(itemState: .gray)  //  fixed: Saturday, no need in data
                CashFlowGridItem(itemState: .gray)  //  fixed: Sunday, no need in data
                CashFlowGridItem(itemState: .none)  //  fixed: empty space for active week shevron, no need in data
                //  MARK: НЕ ЗАБЫТЬ УДАЛИТЬ!!!
                //                CashFlowGridItem(itemState: .none)  //  fixed: empty space for active week shevron, no need in data
            }
        }
        .onTapGesture {
            self.activeWeek = self.weekNo
            self.userData.baseDate = self.weekStartDate
            self.header = self.weekStartDate.toString(format: "dd.MM")
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
        }
        .modifier(GridHighlighter(show: activeWeek == weekNo))
        .animation(.spring())
    }
}

struct GridHighlighter: ViewModifier {
    let show: Bool
    
    func body(content: Content) -> some View {
        content
            .contrast(show ? 1 : 0.4)
            .overlay(
                Image(systemName: "chevron.compact.up")
                    .offset(y: 60)
                    .opacity(show ? 1.0 : 0.0)
                    .foregroundColor(.systemOrange))
    }
}


#if DEBUG
struct CashFlowGridColumn_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CashFlowGridColumn(activeWeek: .constant(5),
                               cashFlows: [CalendarCashFlow(date: Date().addDays(0), portfolioName: "Optimus", emitent: "VTB", instrument: "GHS-457", amount: 12345, type: .coupon)],
                               weekNo: 5,
                               weekStartDate: Date().firstDayOfWeekRU)
        }
        .environmentObject(UserData())
        .environment(\.colorScheme, .dark)
        //            .preferredColorScheme(.dark)
    }
}
#endif

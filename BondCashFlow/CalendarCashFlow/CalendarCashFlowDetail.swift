//
//  CalendarCashFlowDetail.swift
//  TestCombine
//
//  Created by Igor Malyarov on 29.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct CalendarCashFlowDetail: View {
    @EnvironmentObject var userData: UserData
    @Environment(\.presentationMode) var presentation

    var flows: [CalendarCashFlow]
    
    var body: some View {
        NavigationView {
            
            VStack(alignment: .leading, spacing: 8) {
                
                CalendarCashFlowDetailHeader(date: flows.map({ $0.date }).min() ?? .distantPast,
                                             total: flows.reduce(0, { $0 + $1.amount }))
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    ForEach(flows.map({ $0.portfolioName }).removingDuplicates(), id:\.self) { portfolioName in
                        
                        VStack(alignment: .leading, spacing: 12) {
                            
                            CalendarCashFlowDetailPortfolioName(name: portfolioName)
                            
                            ForEach(self.flows.filter({ $0.portfolioName == portfolioName })) { flow in
                                CalendarCFRow(title: flow.emitent,
                                              subtitle: flow.instrument,
                                              detail: flow.amount.formattedGrouped,
                                              subdetail: flow.type.rawValue)
                            }
                            
                            CalendarCashFlowDetailPortfolioTotal(
                                face: self.flows.filter({ $0.portfolioName == portfolioName && $0.type == .face }).reduce(0, { $0 + $1.amount }),
                                coupon: self.flows.filter({ $0.portfolioName == portfolioName && $0.type == .coupon }).reduce(0, { $0 + $1.amount }),
                                amount: self.flows.filter({ $0.portfolioName == portfolioName }).reduce(0, { $0 + $1.amount }
                                )
                            )
                        }
                    }
                }
            }
            .padding()
                
            .navigationBarTitle(flows.map({ $0.date }).min() ?? .distantPast)
                
            .navigationBarItems(trailing: Button(action: {
                self.presentation.wrappedValue.dismiss()
            }) {
                Text("Закрыть")
                .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 0))
            }
            )
        }
    }
}

struct CalendarCashFlowDetailHeader: View {
    var date: Date
    var total: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Spacer()
                    
                    Text(total.formattedGrouped)
                        .font(Font.system(size: 60))
                        .foregroundColor(.systemOrange)
                }
                
                Text("Ожидаемые поступления по всем портфелям " + date.toString())
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct CalendarCashFlowDetailPortfolioName: View {
    var name: String
    
    var body: some View {
        HStack {
            Text(name)
                .font(.largeTitle)
                .fontWeight(.light)
                .foregroundColor(.systemOrange)
                .padding(.vertical)
            Spacer()
        }
    }
}

struct CalendarCashFlowDetailPortfolioTotal: View {
    var face: Int
    var coupon: Int
    var amount: Int
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 2) {
                Text("Н: " + face.formattedGrouped)
                Text("К: " + coupon.formattedGrouped)
            }
            .font(.caption)
            .foregroundColor(.systemGray2)
            
            Spacer()
            
            Text(amount.formattedGrouped)
                .font(.title)
                .foregroundColor(.systemOrange)
        }
        .padding(.vertical)
    }
}

struct CalendarCashFlowDetail_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CalendarCashFlowDetail(flows: ccf2)
                .environment(\.colorScheme, .dark)
            
            CalendarCashFlowDetail(flows: ccf2)
                .environment(\.sizeCategory, .extraLarge)
            
            CalendarCashFlowDetailHeader(date: Date().addWeeks(2), total: 98765432)
            
            CalendarCashFlowDetailPortfolioName(name: "Optimus Prime")
            
            CalendarCashFlowDetailPortfolioTotal(face: 1_000_000, coupon: 200_000, amount: 1_200_000)
        }
        .previewLayout(.sizeThatFits)
        .environmentObject(UserData())
    }
}

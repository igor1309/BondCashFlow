//
//  CalendarCashFlowDetail.swift
//  TestCombine
//
//  Created by Igor Malyarov on 29.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct CalendarCashFlowDetail: View {
    @Environment(\.presentationMode) var presentation
    var ccf: CalCashFlow
    
    var body: some View {
        NavigationView {
            
            VStack(alignment: .leading, spacing: 8) {
                
                CalendarCashFlowDetailHeader(date: ccf.date, total: ccf.total)
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    ForEach(ccf.flows.map({ $0.portfolioName }).removingDuplicates(), id:\.self) { portfolioName in
                        
                        VStack(alignment: .leading, spacing: 12) {
                            
                            CalendarCashFlowDetailPortfolioName(name: portfolioName)
                            
                            ForEach(self.ccf.flows.filter({ $0.portfolioName == portfolioName })) { item in
                                CalendarCashFlowRow(documentRus: item.documentRus,
                                                    amount: item.amount,
                                                    flowType: item.flowType)
                            }
                            
                            CalendarCashFlowDetailPortfolioTotal(
                                principal: self.ccf.flows.filter({ $0.portfolioName == portfolioName && $0.flowType == .principal }).reduce(0, { $0 + $1.amount }),
                                coupon: self.ccf.flows.filter({ $0.portfolioName == portfolioName && $0.flowType == .coupon }).reduce(0, { $0 + $1.amount }),
                                amount: self.ccf.flows.filter({ $0.portfolioName == portfolioName }).reduce(0, { $0 + $1.amount })
                            )
                        }
                    }
                }
            }
            .padding()
                
            .navigationBarTitle(Date().addWeeks(5).toString())
                
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
        Text(name)
            .font(.largeTitle)
            .fontWeight(.light)
            .foregroundColor(.systemOrange)
            .padding(.vertical)    }
}

struct CalendarCashFlowDetailPortfolioTotal: View {
    var principal: Int
    var coupon: Int
    var amount: Int
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 2) {
                Text("Н: " + principal.formattedGrouped)
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
            CalendarCashFlowDetail(ccf: ccf)
                .environment(\.colorScheme, .dark)
            
            CalendarCashFlowDetail(ccf: ccf)
                .environment(\.sizeCategory, .extraLarge)
            
            CalendarCashFlowDetailHeader(date: Date().addWeeks(2), total: 98765432)
            
            CalendarCashFlowDetailPortfolioName(name: "Optimus Prime")
            
            CalendarCashFlowDetailPortfolioTotal(principal: 1_000_000, coupon: 200_000, amount: 1_200_000)
        }
        .previewLayout(.sizeThatFits)
    }
}

//
//  CashFlowList.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 22.07.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct CashFlowList: View {
    
    //  MARK: - TODO filter by selected portfolio
    
    @EnvironmentObject private var userData: UserData
    
    var body: some View {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {
                    //  MARK:- псевдохак чтобы ScrollView скроллился наверх сам
//                    Text("Base Date: " + userData.baseDate.toString())
//                    .font(.caption)
//                    .foregroundColor(Color.secondary)
//                    .padding(.vertical)
//                    
                    ForEach(0 ..< 52) { weekNo in
                        CashFlowRow(weekNo: weekNo)
                    }
                }
            }
//            .padding(.top)
    }
}

#if DEBUG
struct CashFlowList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CashFlowList()
                
                .navigationBarTitle("Cash Flow")
        }
        .preferredColorScheme(.dark)
        .environmentObject(UserData())
        .environment(\.sizeCategory, .extraLarge)
    }
}
#endif

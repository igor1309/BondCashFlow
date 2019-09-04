//
//  CashFlowView.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 23.07.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct CashFlowView: View {
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        
        //  MARK: - TODO filter by selected portfolio
        
        VStack(alignment: .leading, spacing: 0) {
            
            HStack {
                Spacer()
                
                Text("Base Date: " + userData.baseDate.toString())
                    .font(.caption)
                    .foregroundColor(Color.secondary)
                    .padding(.horizontal)
            }
            
            CashFlowGrid()
                .padding(.horizontal)
                .padding(.vertical, 4)
            
            CashFlowList()
                //  MARK: old edition:
                // ScrollView(.vertical, showsIndicators: false) {
                //     VStack(alignment: .leading, spacing: 0) {
                //         ForEach(0 ..< 52) { weekNo in
                //             CashFlowRow(weekNo: weekNo)
                //                 .environmentObject(self.userData)
                //         }
                //     }
                // }
                .padding(.horizontal)
        }
    }
}

#if DEBUG
struct CashFlowView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CashFlowView()
                
                .navigationBarTitle("Потоки")
            
        }
        .environmentObject(UserData())
        .preferredColorScheme(.dark)
    }
}
#endif

//
//  PortfolioList.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 01.09.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct PortfolioList: View {
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 8) {
                ForEach(userData.portfolios.indexed(), id: \.1.id) { index, _ in
                    PortfolioRow(portfolio: self.$userData.portfolios[index])
                }
            }
        }
        .padding([.top, .leading, .trailing])
        
        .navigationBarTitle("Портфели")

    }
}

struct PortfolioList_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioList()
            .environmentObject(UserData())
    }
}

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
        List {
            ForEach(userData.portfolios, id: \.self) { portfolio in
                PortfolioRow(portfolio: portfolio)
            }
        }
            
        .navigationBarTitle("Портфели")
    }
}

struct PortfolioList_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioList()
            .environmentObject(UserData())
    }
}

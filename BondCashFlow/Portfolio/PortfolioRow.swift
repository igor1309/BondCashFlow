//
//  PortfolioRow.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 09.09.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct PortfolioRow: View {
    @EnvironmentObject var userData: UserData
    @State private var showDetail = false
    
    @Binding var portfolio: Portfolio
    
    /// `Portfolio Row structure`
    ///    var broker: String
    ///    var name: String
    ///    var portfolioNote: String
    ///    var portfolioValue = 13_000_000
    ///    var portfolioFaceValue = 12_500_000
    ///    var couponAmount: Int
    ///    var couponDate: Date
    ///    var emissionsList: String
    
    func faceValueForPortfolio(_ portfolio: Portfolio) -> Int {
        let positionsForPortfolio = userData.positions.filter { $0.portfolioID == portfolio.id }
        
        var faceValue = 0
        
        for position in positionsForPortfolio {
            let emission = userData.emissions.first(where: { $0.id == position.emissionID })
           
            faceValue += position.qty * Int(emission?.nominalPrice ?? 0)
        }
        
        return faceValue
    }
    
    var body: some View {
        
        //  MARK: ВЕРНУТЬ КОГДА ПРИДУМАЮ КАК СЧИТАТЬ СТОИМОСТЬ
        
        Row2(topline: portfolio.broker,
             title: portfolio.name,
             ///    рыночную стоимость пока неясно как считать
            //             detail: "#н/д",
            //             detailExtra: "стоимость",
            detail: faceValueForPortfolio(portfolio).formattedGrouped,
            detailExtra: "номинальная стоимость",
            title2: portfolio.note,
            subtitle: stringFromArray(userData.getEmissionNamesForPortfilo(portfolio)),
            subdetail: userData.nearestFlowForPortfolio(portfolio).formattedGrouped,
            extraline: userData.nearestFlowDateForPortfolio(portfolio).toString())
            
            .contextMenu {
                Button(action: {
                    self.showDetail = true
                }) {
                    HStack {
                        Image(systemName: "pencil.and.outline")
                        Spacer()
                        Text("Редактировать")
                    }
                }
        }
            
        .sheet(isPresented: $showDetail) {
            PortfolioDetail(portfolio: self.$portfolio)
                .environmentObject(self.userData)
        }
    }
}

struct PortfolioRow_Previews: PreviewProvider {
    static var previews: some View {
        let portfolio = Portfolio(name: "Optimus Prime", broker: "Альфа Директ", comment: "Igor")
        
        return NavigationView {
            List {
                PortfolioRow(portfolio: .constant(portfolio))
            }
            .navigationBarTitle("Портфели")
        }
        .environment(\.colorScheme, .dark)
        .environmentObject(UserData())
    }
}

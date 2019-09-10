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
    @State private var showConfirmation = false
    
    @Binding var portfolio: Portfolio
    
    func deletePortfolio() {
        print("ABOUT TO DELETE PORTFOLIO AND TRANSACTIONS")
        userData.deletePortfolio(portfolio)
    }
    
    /// `Portfolio Row structure`
    ///    var broker: String
    ///    var name: String
    ///    var portfolioNote: String
    ///    var portfolioValue = 13_000_000
    ///    var portfolioFaceValue = 12_500_000
    ///    var couponAmount: Int
    ///    var couponDate: Date
    ///    var emissionsList: String
    
    var body: some View {
        
        let faceValue = userData.faceValueForPortfolio(portfolio)
        let nearestFlowForPortfolio = userData.nearestFlowForPortfolio(portfolio)
        let nearestFlowDateForPortfolio = userData.nearestFlowDateForPortfolio(portfolio)
        
        //  MARK: ВЕРНУТЬ КОГДА ПРИДУМАЮ КАК СЧИТАТЬ СТОИМОСТЬ
        
        return Row2(topline: portfolio.broker,
             title: portfolio.name,
             ///    рыночную стоимость пока неясно как считать
            //             detail: "#н/д",
            //             detailExtra: "стоимость",
            detail: faceValue == 0 ? "#н/д" : faceValue.formattedGrouped,
            detailExtra: "номинальная стоимость",
            title2: portfolio.note,
            subtitle: stringFromArray(userData.getEmissionNamesForPortfilo(portfolio)),
            subdetail: nearestFlowForPortfolio == 0 ? "" : nearestFlowForPortfolio.formattedGrouped,
            extraline: nearestFlowDateForPortfolio == .distantPast ? "#н/д" : nearestFlowDateForPortfolio.toString())
            
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
            Button(action: {
                self.showConfirmation = true
            }) {
                HStack {
                    Image(systemName: "trash.circle")
                    Spacer()
                    Text("Удалить портфель")
                }
            }
        }
            
        .sheet(isPresented: $showDetail) {
            PortfolioDetail(portfolio: self.$portfolio)
                .environmentObject(self.userData)
        }
        
    .actionSheet(isPresented: $showConfirmation) {
            ActionSheet(title: Text("Удалить портфель"),
                        message: Text("и все транзации с ним связанные?\nОтменить удаление невозможно."),
                        buttons: [
                            .cancel(Text("Отмена")),
                            .destructive(Text("Да, удалить портфель и транзакции")) {
                                self.deletePortfolio()
                            }
            ])
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

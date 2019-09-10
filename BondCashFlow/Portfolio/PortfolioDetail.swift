//
//  PortfolioDetail.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 09.09.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct PortfolioDetail: View {
    @EnvironmentObject var userData: UserData
    @Environment(\.presentationMode) var presentation
    @Binding var portfolio: Portfolio
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Название".uppercased())) {
                    TextField("Название портфеля", text: $portfolio.name)
                }
                
                Section(header: Text("Брокер".uppercased())) {
                    TextField("Брокер", text: $portfolio.broker)
                }
                
                Section(header: Text("Комментарий/Примечание".uppercased())) {
                    TextField("Комментарий/Примечание", text: $portfolio.note)
                }
                
                Section(header: Text("TBD: список эмиссий".uppercased())) {
                    Text("TBD: список эмиссий")
                }
            }
                
            .navigationBarTitle("Портфель")
                
            .navigationBarItems(trailing: TrailingButton(name: "Закрыть") {
                self.presentation.wrappedValue.dismiss()
            })
        }
    }
}

struct PortfolioDetail_Previews: PreviewProvider {
    static var previews: some View {
        let portfolio = Portfolio(name: "Optimus Prime", broker: "Альфа Директ", comment: "Igor")
        
        return PortfolioDetail(portfolio: .constant(portfolio))
            
            .environmentObject(UserData())
            .environment(\.colorScheme, .dark)
    }
}

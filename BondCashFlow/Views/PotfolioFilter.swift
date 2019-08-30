//
//  PotfolioFilter.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 24.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct PotfolioFilter: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var userData: UserData
    
    var portfolioNames: [String] {
        userData.portfolios.map({ $0.name })
    }
    
    var body: some View {
        NavigationView {
            Form {
                if userData.hasAtLeastTwoPortfolios {
                    Section(header: Text("Показывать позиции".uppercased())) {
                        Toggle(isOn: $userData.isAllPortfoliosSelected) {
                            Text("Во всех портфелях")
                        }
                    }
                    
                    if !self.userData.isAllPortfoliosSelected {
                        Section(header: Text("Для портфеля".uppercased())) {
                            Picker(selection: self.$userData.selectedPortfolio, label: Text("")//"Портфель")
                            ){
                                ForEach(portfolioNames, id: \.self) { name in
                                    Text(name).tag(name)
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                        }
                    }
                } else {
                    EmptyView()
                }
            }
            .navigationBarTitle("Фильтр")
                
            .navigationBarItems(trailing: Button(action: {
                //  MARK: - add actions
                self.presentation.wrappedValue.dismiss()
            }) {
                Text("Закрыть")
            })
        }
    }
}

struct PotfolioFilter_Previews: PreviewProvider {
    static var previews: some View {
        PotfolioFilter()
            .environmentObject(UserData())
    }
}

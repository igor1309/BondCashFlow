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
    
    var body: some View {
        PotfolioFilterGuts(isAllPortfoliosSelected: userData.selectedPortfolioID == nil,
                           selectedPortfolioName: userData.selectedPortfolioName)
    }
}


struct PotfolioFilterGuts: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var userData: UserData
    
    var isAllPortfoliosSelected: Bool
    var selectedPortfolioName: String
    
    @State private var draftIsAllPortfoliosSelected: Bool
    @State private var draftSelectedPortfolio: String
    
    init(isAllPortfoliosSelected: Bool, selectedPortfolioName: String) {
        self.isAllPortfoliosSelected = isAllPortfoliosSelected
        self.selectedPortfolioName = selectedPortfolioName
        self._draftIsAllPortfoliosSelected = State(initialValue: isAllPortfoliosSelected)
        self._draftSelectedPortfolio = State(initialValue: selectedPortfolioName)
    }
    
    func applyAndClose() {
        userData.updateSelectedPortfolio(isAllSelected: draftIsAllPortfoliosSelected,
                                         selectedPorfolioName: draftSelectedPortfolio)
        
        presentation.wrappedValue.dismiss()
    }
    
    var body: some View {
        NavigationView {
            Form {
                if userData.hasAtLeastTwoPortfolios {
                    Section(header: Text("Показывать позиции".uppercased())) {
                        Toggle(isOn: $draftIsAllPortfoliosSelected) {
                            Text("Во всех портфелях")
                        }
                    }
                    
                    if !draftIsAllPortfoliosSelected {
                        Section(header: Text("Для портфеля".uppercased())) {
                            Picker(selection: $draftSelectedPortfolio, label: Text("")){
                                ForEach(userData.portfolios, id: \.self) { portfolio in
                                    Text(portfolio.name).tag(portfolio.name)
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                        }
                    }
                } else {
                    Text("Нет портфелей")
                        .padding()
                }
            }
                
            .navigationBarTitle("Фильтр")
                
            .navigationBarItems(
                trailing: TrailingButton(name: "Применить") {
                    self.applyAndClose()
                }
            )
        }
    }
}

struct PotfolioFilter_Previews: PreviewProvider {
    static var previews: some View {
        PotfolioFilter()
            .environmentObject(UserData())
    }
}

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
    @EnvironmentObject var settings: SettingsStore
    
    @State private var draftIsAllPortfoliosSelected: Bool
    @State private var draftSelectedPortfolio: String
    
    var isAllPortfoliosSelected: Bool
    var selectedPortfolio: String
    
    init(isAllPortfoliosSelected: Bool, selectedPortfolio: String) {
        self.isAllPortfoliosSelected = isAllPortfoliosSelected
        self.selectedPortfolio = selectedPortfolio
        self._draftIsAllPortfoliosSelected = State(initialValue: isAllPortfoliosSelected)
        self._draftSelectedPortfolio = State(initialValue: selectedPortfolio)
    }
    
    func applyAndClose() {
        settings.isAllPortfoliosSelected = draftIsAllPortfoliosSelected
        settings.selectedPortfolio = draftSelectedPortfolio
        settings.selectedPortfolioID = userData.portfolios.first(where: { $0.name == draftSelectedPortfolio })?.id ?? UUID()
        
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
        PotfolioFilter(isAllPortfoliosSelected: true,
                       selectedPortfolio: "")
            .environmentObject(UserData())
            .environmentObject(SettingsStore())
    }
}

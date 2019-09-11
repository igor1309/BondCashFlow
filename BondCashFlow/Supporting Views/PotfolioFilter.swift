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
    
    var body: some View {
        NavigationView {
            Form {
                if userData.hasAtLeastTwoPortfolios {
                    Section(header: Text("Показывать позиции".uppercased())) {
                        Toggle(isOn: $settings.isAllPortfoliosSelected) {
                            Text("Во всех портфелях")
                        }
                    }
                    
                    if !self.settings.isAllPortfoliosSelected {
                        Section(header: Text("Для портфеля".uppercased())) {
                            Picker(selection: self.$settings.selectedPortfolio, label: Text("")//"Портфель")
                            ){
                                ForEach(userData.portfolioNames, id: \.self) { name in
                                    Text(name).tag(name)
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
                    self.presentation.wrappedValue.dismiss()
                }
            )
        }
    }
}

struct PotfolioFilter_Previews: PreviewProvider {
    static var previews: some View {
        PotfolioFilter()
            .environmentObject(UserData())
            .environmentObject(SettingsStore())
    }
}

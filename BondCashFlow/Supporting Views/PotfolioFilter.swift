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
    @State private var showPortfolioList = false
    
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
                    EmptyView()
                }
                
                Button("Показать список портфелей") {
                    self.showPortfolioList = true
                }
            }
            .navigationBarTitle("Фильтр")
                
            .navigationBarItems(trailing: Button(action: {
                //  MARK: - add actions
                self.presentation.wrappedValue.dismiss()
            }) {
                Text("Применить")
                    .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 0))
                
            })
                
                .sheet(isPresented: $showPortfolioList) {
                    PortfolioList()
                        .environmentObject(self.userData)
            }
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

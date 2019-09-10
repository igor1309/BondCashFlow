//
//  PositionList.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 24.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct PositionList: View {
    var positions: [Position]
    
    var body: some View {
        List {
            ForEach(positions, id: \.self) { position in
                PositionRow(position: position)
            }
        }
    }
}


struct PositionListView: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var settings: SettingsStore
    
    var body: some View {
        VStack(alignment: .leading) {

            Text(settings.isAllPortfoliosSelected ? "все портфели" : "Портфель " + settings.selectedPortfolio)
                .foregroundColor(.secondary)
                .font(.caption)
                .padding(.horizontal)
            
            PositionList(positions: userData.positions
                .filter({
                    if settings.isAllPortfoliosSelected {
                        return true
                    } else {
                        return $0.portfolioID == settings.selectedPortfolioID
                    }
                })
                .sorted(by: {
                    if settings.isAllPortfoliosSelected {
                        return ($0.emissionID) < ($1.emissionID)
                    } else {
                        return $0.emissionID < $1.emissionID
                    }
                }))
                .environmentObject(self.userData)
        }
            
        .navigationBarTitle("Позиции")
            
    }
}

struct Portfolio_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PositionListView()
        }
        .environmentObject(UserData())
        .environmentObject(SettingsStore())
        .environment(\.colorScheme, .dark)
    }
}

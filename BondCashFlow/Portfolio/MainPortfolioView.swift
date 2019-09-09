//
//  MainPortfolioView.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 09.09.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct PositionForEmission: View {
    @EnvironmentObject var userData: UserData
    var emissionID: EmissionID
    
    var body: some View {
        
        let emission = userData.emissions.first(where: { $0.id == emissionID })
        
        let positionsForEmissionID = userData.positions.filter { $0.emissionID == self.emissionID }
        
        let portfolioIDsForEmissionIDs = positionsForEmissionID.map { $0.portfolioID }.removingDuplicates()
        
        let portfolioNamesForEmissionID = userData.portfolios
            .filter { portfolioIDsForEmissionIDs.contains($0.id) }
            .map { $0.name }
        
        let nearestFlowDate = userData.flows.filter { $0.date >= Date() }.map { $0.date }.min()
        
        let qty = positionsForEmissionID.reduce(0, { $0 + $1.qty })
        
        return Row(title: emission?.documentRus ?? "#н/д",
                   detail: qty.formattedGrouped,
                   detailExtra: "кол-во",
                   title2: stringFromArray(portfolioNamesForEmissionID),
                   detail2: (Int(emission?.nominalPrice ?? 0) * qty).formattedGrouped,
                   subtitle: "<TBD: nearest flow>",
                   subdetail: emission?.maturityDate.toString() ?? "#н/д",
                   extraline: nearestFlowDate?.toString() ?? "#н/д")
    }
}


struct GlobalPositionList: View {
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        List {
            ForEach(userData.positions.map { $0.emissionID }.removingDuplicates().sorted(), id: \.self) {
                
                emissionID in
                
                PositionForEmission(emissionID: emissionID)
                
                //                Row(title: self.userData.emissions.first(where: { $0.id == emissionID })?.documentRus ?? "#н/д",
                //                    detail: self.userData.positions
                //                        //                        .filter { $0.id == emissionID }
                //                        .reduce(0, { $0 + $1.qty }).formattedGrouped,
                //                    subtitle: "",
                //                    subdetail: "")
            }
        }
    }
}



struct MainPortfolioView: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var settings: SettingsStore
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            Picker(selection: $settings.selectedPortfolioView, label: Text("")) {
                Text("портфели").tag("портфели")
                Text("по выпускам").tag("по выпускам")
                Text("позиции").tag("позиции")
            }
                //                .border(Color.systemPink)
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
            //            .border(Color.systemPink)
            
            if settings.selectedPortfolioView == "портфели" {
                PortfolioList()
                //                .border(Color.systemPink)
            }
            
            if settings.selectedPortfolioView == "по выпускам" {
                GlobalPositionList()
            }
            
            if settings.selectedPortfolioView == "позиции" {
                PortfolioView()
            }
        }
            
        .navigationBarTitle("Портфели")
    }
}

struct MainPortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MainPortfolioView()
        }
            
        .environmentObject(UserData())
        .environmentObject(SettingsStore())
        .environment(\.colorScheme, .dark)
    }
}

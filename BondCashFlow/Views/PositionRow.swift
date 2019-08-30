//
//  PositionRow.swift
//  BondsCashFlow
//
//  Created by Igor Malyarov on 27.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct PositionRow: View {
    @EnvironmentObject var userData: UserData
    
    var portfolioName: String
    var position: Position
    
    @State private var showDetail = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(position.isin)
                
                Spacer()
                
                Text(position.qty.formattedGrouped)
            }
            
            HStack {
                Text(portfolioName)
                    .font(.caption)
                    .fontWeight(.light)
                    .foregroundColor(.systemOrange)
                
                Spacer()
            }
        }
        .onTapGesture {
            self.showDetail = true
        }
            
        .sheet(isPresented: $showDetail,
               content: {
                PositionDetail(portfolioName: self.userData.selectedPortfolio,
                               position: self.position)
                    .environmentObject(self.userData)
        })
        
    }
}

struct PositionRow_Previews: PreviewProvider {
    static var previews: some View {
        PositionRow(portfolioName: "Bumblebee",
                    position: Position(isin: "RU000A0ZZAR2",
                                       emissionID: 626,
                                       qty: 5555))
            .environmentObject(UserData())
    }
}

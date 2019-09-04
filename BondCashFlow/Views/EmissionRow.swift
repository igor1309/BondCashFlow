//
//  EmissionRow.swift
//  BondsCashFlow
//
//  Created by Igor Malyarov on 27.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct EmissionSubRowIDISINEmiitent: View {
    var emission: Emission
    
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Text("#" + String(emission.id))
            
            Text(emission.isinCode.isEmpty ? "" : emission.isinCode)
            
            Spacer()
            
            Text(emission.emitentNameRus)
                .fixedSize(horizontal: false, vertical: true)
        }
        .font(.caption)
        .foregroundColor(.systemOrange)
    }
}


struct EmissionSubRow: View {
    @EnvironmentObject var userData: UserData
    var emission: Emission
    var bigStar: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            
            EmissionSubRowIDISINEmiitent(emission: emission)
            
            Text(emission.documentRus)
                .fixedSize(horizontal: false, vertical: true)
            
            HStack(alignment: .top) {
                Image(systemName: userData.favoriteEmissions[emission.id] ?? false ? "star.fill" : "star")
                    .foregroundColor(userData.favoriteEmissions[emission.id] ?? false ? .systemOrange : .systemGray)
                    .imageScale(bigStar ? .large : .medium)
                    .padding(.top, 10)
                
                VStack(alignment: .leading) {
                    
                    Text("cupon_period " + emission.cupon_period.formattedGrouped)
                    
                    Text(emission.cupon_rus.isEmpty ? "-" : "cupon_rus " + emission.cupon_rus)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .font(.caption)
            }
            .foregroundColor(.secondary)
        }
        
    }
}

struct EmissionRow: View {
    @EnvironmentObject var userData: UserData
    
    var emission: Emission
    @State private var showDetail = false
    
    var body: some View {
        EmissionSubRow(emission: emission)
            //            .environmentObject(userData)
            .onTapGesture {
                self.showDetail = true
        }
            
        .sheet(isPresented: $showDetail,
               content: { EmissionDetail(emission: self.emission,
                                         isFav: self.userData.favoriteEmissions[self.emission.id] ?? false)
                .environmentObject(self.userData)
        })
    }
}

struct EmissionRow_Previews: PreviewProvider {
    static var previews: some View {
        EmissionRow(emission: Emission())
            .environmentObject(UserData())
            .previewLayout(.sizeThatFits)
    }
}

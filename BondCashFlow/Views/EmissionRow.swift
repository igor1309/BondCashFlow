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
    @State private var showModal = false
    @State var modal: Modal = .emissionDetail
    enum Modal { case emissionDetail, addPosition }
    
    //  MARK: TODO after fix in UserData replace this func
    func unfavEmission() {
        self.userData.favoriteEmissions[self.emission.id] = nil
    }
    
    var body: some View {
        EmissionSubRow(emission: emission)
            //            .environmentObject(userData)
            .onTapGesture {
                self.modal = .emissionDetail
                self.showModal = true
        }
        .contextMenu {
            Button(action: {
                /// fav emission otherwise it would not show up in a list of emissions in AppPosition view
                self.userData.favEmission(emissionID: self.emission.id)
                
                self.showModal = true
                self.modal = .addPosition
            }) {
                HStack {
                    Image(systemName: "cart.badge.plus")
                    Spacer()
                    Text("Купить этот выпуск")
                }
            }
            
            if (userData.favoriteEmissions[emission.id] ?? false) {
                Button(action: {
                    self.unfavEmission()
                }) {
                    HStack {
                        Image(systemName: "star.fill")
                        Spacer()
                        Text("Убрать из избранных")
                    }
                }
            } else {
                Button(action: {
                    /// fav emission otherwise it would not show up in a list of emissions in AppPosition view
                    self.userData.favEmission(emissionID: self.emission.id)
                }) {
                    HStack {
                        Image(systemName: "star")
                        Spacer()
                        Text("Добавить в избранные")
                    }
                }
            }
        }
            
        .sheet(isPresented: $showModal,
               content: {
                if self.modal == .emissionDetail {
                    EmissionDetail(emission: self.emission,
                                   isFav: self.userData.favoriteEmissions[self.emission.id] ?? false)
                        .environmentObject(self.userData)
                }
                
                if self.modal == .addPosition {
                    AddPosition(proposedEmissionID: self.emission.id)
                        .environmentObject(self.userData)
                }
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

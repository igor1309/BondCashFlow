//
//  PositionDetail.swift
//  BondsCashFlow
//
//  Created by Igor Malyarov on 27.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct PositionDetail: View {
    @EnvironmentObject var userData: UserData
    @Environment(\.presentationMode) var presentation
    @State private var showAlert = false
    
    var portfolioName: String
    var position: Position
    
    func deletePosition() {
        if let portfolioIndex =
            userData.portfolios.firstIndex(where: { $0.name == portfolioName }) {
            if let positionIndex =
                userData.portfolios[portfolioIndex].positions.firstIndex(where: { $0.isin == position.isin }) {
                
                userData.portfolios[portfolioIndex].positions.remove(at: positionIndex)
            }
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Портфель".uppercased())
                ){
                    Text(portfolioName)
                }
                
                Section(header: Text("Код выпуска (ISIN)".uppercased())
                ){
                    Text(position.isin)
                }
                
                Section(header: Text("Количество".uppercased())
                ){
                    Text(position.qty.formattedGrouped)
                }
                
                Button(action: {
                    self.showAlert = true
                }) {
                    Text("Удалить").foregroundColor(.systemRed)
                }
                
            }
            .navigationBarTitle(position.isin)
                
            .navigationBarBackButtonHidden(true)
                
            .navigationBarItems(trailing: Button(action: {
                self.presentation.wrappedValue.dismiss()
            }) {
                Image(systemName: "xmark.circle")
                    .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 0))
            })
                
                .actionSheet(isPresented: $showAlert) { () -> ActionSheet in
                    ActionSheet(title: Text("Удалить позицию?"),
                                message: Text("Отменить действие будет невозможно."),
                                buttons: [
                                    .cancel(),
                                    .destructive(Text("Удалить позицию"),
                                                 action: {
                                                    self.deletePosition()
                                                    self.presentation.wrappedValue.dismiss()
                                    })
                    ])
            }
        }
    }
}

struct PositionDetail_Previews: PreviewProvider {
    static var previews: some View {
        PositionDetail(portfolioName: "Bumblebee",
                       position: Position(isin: "RU000A0ZZAR2", emissionID: 11789, qty: 5555))
            .environmentObject(UserData())
    }
}

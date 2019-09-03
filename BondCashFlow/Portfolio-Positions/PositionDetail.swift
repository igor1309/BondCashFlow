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
    
    var position: Position
    var emission: Emission?
    
    func deletePosition() {
        if let positionIndex =
            userData.positions.firstIndex(where: { $0 == position }) {
            userData.positions.remove(at: positionIndex)
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Портфель".uppercased())
                ){
                    Text(position.portfolioName)
                }
                
                Section(header: Text("Выпуск".uppercased())
                ){
                    Text("TBD").foregroundColor(.systemRed)
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
                
                //  MARK: get more data about emission an put into title
                .navigationBarTitle(String(position.emissionID))
                
                .navigationBarBackButtonHidden(true)
                
                .navigationBarItems(
                    trailing: TrailingButton(name: "Закрыть") {
                        self.presentation.wrappedValue.dismiss()
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
        PositionDetail(position: Position(portfolioName: "Bumblebee", emissionID: 11789, qty: 5555))
            .environmentObject(UserData())
    }
}

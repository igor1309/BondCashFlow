//
//  PositionDetail.swift
//  BondsCashFlow
//
//  Created by Igor Malyarov on 27.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct PositionRowInDetail: View {
    var title: String
    var detail: String
    
    var body: some View {
        HStack {
            Text(title)
            
            Spacer()
            
            Text(detail)
        }
    }
}


struct PositionDetail: View {
    @EnvironmentObject var userData: UserData
    @Environment(\.presentationMode) var presentation
    @State private var showFlows = false
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
                
                Section(header: Text("………".uppercased())) {
                    PositionRowInDetail(title: "Выпуск", detail: emission?.documentRus ?? "#n/a")
                    
                    PositionRowInDetail(title: "emissionID", detail: String(position.emissionID))
                        .foregroundColor(.secondary)
                    
                    PositionRowInDetail(title: "Количество", detail: position.qty.formattedGrouped)
                    
                    PositionRowInDetail(title: "Портфель", detail: position.portfolioName)
                }
                
                Section(header: Text("Количество".uppercased())
                ){
                    Text(position.qty.formattedGrouped)
                }
                
                Section(footer: Text(emission == nil ? "Этого выпуска нет в базе" : "")) {
                    Button(action: {
                        self.showFlows = true
                    }) {
                        Text("Потоки по выпуску")
                    }
                    .disabled(emission == nil)
                }
                
                Section {
                    Button(action: {
                        self.showAlert = true
                    }) {
                        Text("Удалить позицию").foregroundColor(.systemRed)
                    }
                }
            }
                
                //  MARK: get more data about emission an put into title
                .navigationBarTitle("Позиция")
                
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
            
            .sheet(isPresented: $showFlows) {
                EmissionDetail2(emission: self.emission!)
                    .environmentObject(self.userData)
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

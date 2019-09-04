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
                
                Section(footer: Text("Редактирование позиции (количество облигаций) будет сделано в следующей версии. В этой версии нужно сначала удалить позицию и потом завести новую с нужным количеством.").foregroundColor(.systemTeal)) {
                    Text(emission?.documentRus ?? "#n/a")
                    
                    PositionRowInDetail(title: "emissionID", detail: String(position.emissionID))
                        .foregroundColor(.secondary)
                    
                    PositionRowInDetail(title: "Портфель", detail: position.portfolioName)
                    
                    //  MARK: TODO: make qty editable
                    //  using QtyTextField(qty: T##Binding<Int>, error: T##String)
                    PositionRowInDetail(title: "Количество", detail: position.qty.formattedGrouped)
                        .foregroundColor(Color.systemOrange)
                }
                
                Section {
                    Button(action: {
                        self.showAlert = true
                    }) {
                        Text("Удалить позицию").foregroundColor(.systemRed)
                    }
                }
                
                if emission != nil {
                    Section(header: Text("Потоки".uppercased())) {
                        FlowsList(flows: userData.flows
                            .filter({ $0.emissionID == emission!.id })
                            .sorted(by: { $0.couponNum < $1.couponNum }), qty: self.position.qty
                        )
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
        }
    }
}

struct PositionDetail_Previews: PreviewProvider {
    static var previews: some View {
        PositionDetail(position: Position(portfolioName: "Bumblebee", emissionID: 11789, qty: 5555))
            .environmentObject(UserData())
    }
}

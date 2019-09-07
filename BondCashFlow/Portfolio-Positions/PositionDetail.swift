//
//  PositionDetail.swift
//  BondsCashFlow
//
//  Created by Igor Malyarov on 27.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct PositionQtySection: View {
    @EnvironmentObject var userData: UserData
    var position: Position
    @Binding var qty: Int
    @State private var draftQty: Int
    @State private var isEditing: Bool
    
    init(position: Position, qty: Binding<Int>) {
        self.position = position
        self._qty = qty
        self._draftQty = State(initialValue: qty.wrappedValue)
        self._isEditing = State(initialValue: false)
    }
    
    func savePosition() {
        if let index = userData.positions.firstIndex(where: { $0.id == position.id }) {
            userData.positions[index].qty = draftQty
            qty = draftQty
        }
    }
    var body: some View {
        Section(header: Text("Количество".uppercased() + (isEditing ? " qty: \(qty) draftQty: \(draftQty)" : "")),
                footer: Text(isEditing ? "По окончании редактирования нужно обязательно нажать ВВОД." : "").foregroundColor(.systemTeal)) {
                    
                    //  MARK: TODO: make qty editable
                    //  using QtyTextField(qty: T##Binding<Int>, error: T##String)
                    if isEditing {
                        HStack {
                            TextField("", value: $draftQty, formatter: NumberFormatter(),
                                      onEditingChanged: { isEdited in
                                        print("TextField qty onEditingChanged isEdited: \(isEdited)")
                            },
                                      onCommit: {
                                        print("draftQty: \(self.draftQty)")
                            })
                            
                            Spacer()
                            
                            Button(action: {
                                print("checkmark tapped")
                                self.savePosition()
                                self.isEditing = false
                            }) {
                                Image(systemName: "checkmark")
                                    .padding(.leading)
                                    .padding(.vertical, 8)
                            }
                            //                                    .border(Color.systemPink)
                        }
                    } else {
                        HStack {
                            Text(qty.formattedGrouped)
                                .foregroundColor(Color.systemOrange)
                                .onTapGesture {
                                    self.isEditing = true
                            }
                            
                            Spacer()
                            
                            Button("Редактировать") {
                                self.isEditing = true
                            }
                        }
                    }
        }
    }
}


struct PositionDetail: View {
    @EnvironmentObject var userData: UserData
    @Environment(\.presentationMode) var presentation
    @State private var showAlert: Bool
    @State private var isEditing: Bool
    @State private var qty: Int
    @State private var draftQty: Int
    
    var position: Position
    var emission: Emission?
    
    init(position: Position, emission: Emission?) {
        self._showAlert = State(initialValue: false)
        self._isEditing = State(initialValue: false)
        self._qty = State(initialValue: position.qty)
        self._draftQty = State(initialValue: position.qty)
        self.position = position
        self.emission = emission
    }
    
    func deletePosition() {
        if let positionIndex =
            userData.positions.firstIndex(where: { $0 == position }) {
            userData.positions.remove(at: positionIndex)
            
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.warning)
        }
        
        self.presentation.wrappedValue.dismiss()
    }
    
    func savePosition() {
        if let index = userData.positions.firstIndex(where: { $0.id == position.id }) {
            userData.positions[index] = position
            qty = draftQty
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                
                Section(header: Text("Выпуск #\(String(position.emissionID))".uppercased())) {
                    Text(emission?.documentRus ?? "#n/a")
                }
                
                PositionQtySection(position: position, qty: $qty)
                
                Section(header: Text("Портфель".uppercased())) {
                    Text(position.portfolioName)
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
                                    })
                    ])
            }
        }
    }
}

struct PositionDetail_Previews: PreviewProvider {
    static var previews: some View {
        PositionDetail(position: Position(portfolioName: "Bumblebee", emissionID: 11789, qty: 5555), emission: nil)
            .environmentObject(UserData())
            .environment(\.colorScheme, .dark)
    }
}

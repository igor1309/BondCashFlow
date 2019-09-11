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
    @EnvironmentObject var settings: SettingsStore
    @Environment(\.presentationMode) var presentation
    @State private var showAlert = false
    @State private var isEditing = false
    @State private var draft: Position
    var position: Position
    var emission: Emission?
    
    init(position: Position, emission: Emission?) {
        self.position = position
        self.emission = emission
        self._draft = State(initialValue: position)
    }
    
    func saveAndClose() {
        //  MARK: ПЕРЕНЕСТИ В МОДЕЛЬ!!!
        if let index = userData.positions.firstIndex(where: { $0.id == position.id }) {
            userData.positions[index].qty = draft.qty
        }
        
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.warning)
        
        self.presentation.wrappedValue.dismiss()
    }
    
    
    func deletePosition() {
        //  MARK: ПЕРЕНЕСТИ В МОДЕЛЬ!!!
        if let positionIndex = userData.positions.firstIndex(where: { $0 == position }) {
            userData.positions.remove(at: positionIndex)
        }
        
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.warning)
        
        self.presentation.wrappedValue.dismiss()
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Выпуск #\(String(position.emissionID))".uppercased())) {
                    Text(emission?.documentRus ?? "#n/a")
                    
                    Stepper("Количество бумаг \(draft.qty.formattedGrouped)", value: $draft.qty, in: 1...1_000_000)
                        .foregroundColor(.systemOrange)
                }
                
                Section(header: Text("Портфель".uppercased())) {
                    Text(userData.portfolios.first(where: { $0.id == position.portfolioID })!.name)
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
                        Toggle(isOn: $userData.isFutureFlowsOnly) {
                            Text("Только будущие потоки")
                        }
                        .foregroundColor(.systemOrange)
                        
                        FlowsList(flows: userData.workingFlows
                            .filter({ (self.userData.isFutureFlowsOnly ? $0.date >= Date() : true)
                                && $0.emissionID == emission!.id })
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
                        self.saveAndClose()
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
        PositionDetail(position: Position(portfolioID: UUID(uuidString: "9009E038-AF68-4E55-A15E-F6C5059B79BD") ?? UUID(), emissionID: 11789, qty: 5555), emission: nil)
            .environmentObject(UserData())
            .environmentObject(SettingsStore())
            .environment(\.colorScheme, .dark)
    }
}

//
//  AddPosition.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 24.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct AddPosition: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var userData: UserData
    
    var portfolioNames: [String] {
        userData.portfolios.map({ $0.name })
    }
    
    @State private var selectedPortfolioName: String = ""
    private var portfolioNameErrorNote: String {
        selectedPortfolioName.isEmpty ? "Нужно выбрать портфель" : ""
    }
    
    //    init() {
    //        self._selectedPortfolioName = State(initialValue: userData.selectedPortfolio.isEmpty ? "" : userData.selectedPortfolio)
    //    }
    //
    @State var isin: String = ""    //RU000A0ZZAR2
    private var isinErrorNote: String {
        isin.isEmpty ? "ISIN не может быть пустым" : ""
    }
    
    @State var emissionID: Int = 11111
    private var emissionIDErrorNote: String {
        isin.isEmpty ? "emissionID не может быть пустым" : ""
    }
    
    @State private var qty = 1
    private var qtyErrorNote: String {
        self.qty > 0 ? "" : "Количество облигаций должно быть положительным"
    }
    
    private func portfolioSelected() -> Bool {
        //  MARK: TODO
        selectedPortfolioName.isNotEmpty
    }
    
    private func isinIsValid() -> Bool {
        //  MARK: TODO
        //  нужна проверка на уникальность - нельзя в портфель заводить
        //  еще одну позицию с тем же выпуском
        return isin.isNotEmpty
    }
    
    private func emissionIDIsValid() -> Bool {
        //  MARK: TODO
        self.qty > 0
    }
    
    private func qtyIsValid() -> Bool {
        //  MARK: TODO
        self.qty > 0
    }
    
    func addPosition() {
        let position = Position(isin: self.isin.uppercased(), emissionID: emissionID, qty: self.qty)
        if let index = userData.portfolios.firstIndex(where: { $0.name == selectedPortfolioName }) {
            userData.portfolios[index].positions.append(position)
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Портфель".uppercased()),
                        footer: Text(portfolioNameErrorNote)
                            .foregroundColor(.systemRed)
                ){
                    Picker(selection: $selectedPortfolioName,
                           label: Text("Портфель")
                    ){
                        ForEach(portfolioNames, id: \.self) { name in
                            Text(name).tag(name)
                        }
                    }
                    //                    .onTapGesture {
                    //                        let _ = self.portfolioSelected()
                    //                    }
                }
                
                //  MARK: - а может брать Код выпуска из базы?
                //  или и то и другое?
                //  как проверять??
                Section(header: Text("Код выпуска (ISIN)".uppercased()),
                        footer: Text(isinErrorNote)
                            .foregroundColor(.systemRed)
                ){
                    TextField("ISIN", text: $isin,  //RU000A0ZZAR2
                        //    MARK: - TODO onEditingChanged & onCommit
                        onEditingChanged: { isEdited in
                            let _ = self.isinIsValid()
                    },
                        onCommit: {
                            let _ = self.isinIsValid()
                    })
                    Picker(selection: $isin, label: Text("Код выпуска (ISIN)")) {
                        Text("Выпуск 1").tag("Выпуск 1")
                        Text("Выпуск 2").tag("Выпуск 2")
                    }
                }
                
                Section(header: Text("Номер выпуска".uppercased()),
                        footer: Text(emissionIDErrorNote).foregroundColor(.systemRed)
                ){
                    TextField("Количество",
                              value: $emissionID,
                              formatter: NumberFormatter(),
                              //    MARK: - TODO onEditingChanged & onCommit
                        onEditingChanged: { isEdited in
                            let _ = self.emissionIDIsValid()
                    }, onCommit: {
                        let _ = self.emissionIDIsValid()
                    })
                        .keyboardType(.numberPad)
                }
                
                Section(header: Text("Количество".uppercased()),
                        footer: Text(qtyErrorNote).foregroundColor(.systemRed)
                ){
                    TextField("Количество",
                              value: $qty,
                              formatter: NumberFormatter(),
                              //    MARK: - TODO onEditingChanged & onCommit
                        onEditingChanged: { isEdited in
                            let _ = self.qtyIsValid()
                    }, onCommit: {
                        let _ = self.qtyIsValid()
                    })
                        .keyboardType(.numberPad)
                }
            }
                
            .navigationBarTitle("Новая позиция")
                
            .navigationBarItems(
                leading: Button(action: {
                    self.presentation.wrappedValue.dismiss()
                }) {
                    Text("Cancel").foregroundColor(.systemRed)
                        .padding(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 16))
                },
                
                trailing: Button(action: {
                    //  MARK: - TODO: add actions and validations
                    
                    //  Portfilio must be selected
                    guard self.portfolioSelected() else {
                        print("Error: portfolio is not selected")
                        return
                    }
                    
                    //  validate ISIN
                    guard self.isinIsValid() else {
                        print("Error: isin is not valid")
                        return
                    }
                    
                    //  validate Qty
                    guard self.qtyIsValid() else {
                        print("Error: qty is not valid")
                        return
                    }
                    
                    //  add position
                    self.addPosition()
                    
                    self.presentation.wrappedValue.dismiss()
                }) {
                    Text("Save")
                        .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 0))
            })
        }
    }
}

struct AddPosition_Previews: PreviewProvider {
    static var previews: some View {
        AddPosition()
            .environmentObject(UserData())
    }
}

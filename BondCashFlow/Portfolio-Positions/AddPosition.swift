//
//  AddPosition.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 24.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct PortfolioPicker: View {
    @EnvironmentObject var userData: UserData
    @Binding var selectedPortfolioName: String
    var error: String
    
    var body: some View {
        Section(header: Text("портфель".uppercased()),
                footer: Text(error).foregroundColor(.systemRed)
        ){
            Picker(selection: $selectedPortfolioName,
                   label: Text("Портфель")
            ){
                ForEach(userData.portfolioNames, id: \.self) { name in
                    Text(name).tag(name)
                }
            }
        }
    }
}

struct EmissionPicker: View {
    @EnvironmentObject var userData: UserData
    @Binding var emissionID: Int
    var error: String
    
    var body: some View {
        Section(header: Text("Выпуск".uppercased()),
                footer: Text(error).foregroundColor(.systemRed)
        ){
            Picker("★", selection: $emissionID) {
                ForEach(userData.emissions.filter({ (userData.favoriteEmissions[$0.id] ?? false) }), id: \.self) { emission in
                    Text(emission.documentRus).tag(emission.id)
                }
            }
        }
    }
}

struct QtyTextField: View {
    @Binding var qty: Int
    var error: String
    
    var body: some View {
        Section(header: Text("Количество".uppercased()),
                footer: Text(error).foregroundColor(.systemRed)
        ){
            TextField("Штуки", value: $qty, formatter: NumberFormatter())
                .keyboardType(.numberPad)
        }
    }
}

struct PortfolioListButton: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var userData: UserData
    @State private var showwModal = false
    
    var body: some View {
        Button("Показать список портфелей") {
            self.showwModal = true
        }
            
        .sheet(isPresented: $showwModal, content: {
            PortfolioList()
                .environmentObject(self.userData)
        })
    }
}


struct AddPortfolioButton: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var userData: UserData
    @Binding var portfolioName: String
    @State private var showwModal = false
    
    var body: some View {
        Button(action: {
            self.showwModal = true
        }){
            Text("Новый портфель")
        }
            
        .sheet(isPresented: $showwModal, content: {
            AddPortfolio(portfolioName: self.$portfolioName)
                .environmentObject(self.userData)
        })
        
    }
}


struct AddPosition: View {
    @EnvironmentObject var userData: UserData
    @Environment(\.presentationMode) var presentation
    
    @State private var portfolioName: String = ""
    @State private var emissionID: Int = -1
    @State private var qty: Int = 1
    
    @State private var portfolioNameError: String = ""
    @State private var emissionIDError: String = ""
    @State private var qtyError: String = ""
    
    private var positionIsValid: Bool {
        
        //  MARK: TODO валидация должна происходить при выборе портфеля и эмиссии
        //             а не только при попытке сохраниться
        
        ///  MARK: position should be `unique` (portfolioName & emissionID)
        let position = userData.positions.first(where: { $0.portfolioName == self.portfolioName && $0.emissionID == self.emissionID })
        if position != nil {
            self.emissionIDError = "Такая позиция уже есть в портфеле (\(position!.qty.formattedGrouped) шт)."
            return false
        }
        
        self.portfolioNameError = ""
        self.emissionIDError = ""
        self.qtyError = ""
        
        ///  MARK: position should be `ok`:
        ///     - portfolio selected
        ///     - emissionID selected
        ///     - qty > 0
        
        guard portfolioName.isNotEmpty else {
            self.portfolioNameError = "Нужно выбрать портфель"
            return false
        }
        
        guard emissionID != -1 else {
            self.emissionIDError = "Нужно выбрать выпуск (эмиссию)"
            return false
        }
        
        guard self.qty > 0 else {
            self.qtyError = "Количество облигаций должно быть положительным"
            return false
        }
        
        return true
    }
    
    @State private var showwModal = false
    @State private var modal: ModalType = .portfolioList
    
    private enum ModalType {
        case portfolioList, addPortfolio
    }
    
    private func addPosition() {
        let position = Position(portfolioName: portfolioName, emissionID: emissionID, qty: qty)
        userData.positions.append(position)
    }
    
    var body: some View {
        NavigationView {
            Form {
                PortfolioPicker(selectedPortfolioName: $portfolioName,
                                error: portfolioNameError)
                
                EmissionPicker(emissionID: $emissionID,
                               error: emissionIDError)
                
                QtyTextField(qty: $qty, error: qtyError)
                
                Section(header: Text("Дополнительно".uppercased())
                ){
                    Button(action: {
                        self.modal = .addPortfolio
                        self.showwModal = true
                    }){
                        Text("Новый портфель")
                    }
                    
                    Button("Показать список портфелей") {
                        self.modal = .portfolioList
                        self.showwModal = true
                    }
                    
                    ShowEmissionListButton()
                }
            }
                
            .navigationBarTitle("Новая позиция")
                
            .navigationBarItems(
                leading: Button(action: {
                    self.presentation.wrappedValue.dismiss()
                }) {
                    Text("Отмена")
                        .foregroundColor(.systemRed)
                        .padding(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 16))
                },
                trailing: Button(action: {
                    //  MARK: finish this
                    if self.positionIsValid {
                        let position = Position(portfolioName: self.portfolioName, emissionID: self.emissionID, qty: self.qty)
                        self.userData.positions.append(position)
                        self.presentation.wrappedValue.dismiss()
                    }
                }) {
                    Text("Сохранить")
                        .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 0))
                }
            )
                
                
                .sheet(isPresented: $showwModal, content: {
                    if self.modal == .portfolioList {
                        PortfolioList()
                            .environmentObject(self.userData)
                    }
                    
                    if self.modal == .addPortfolio {
                        AddPortfolio(portfolioName: self.$portfolioName)
                            .environmentObject(self.userData)
                    }
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

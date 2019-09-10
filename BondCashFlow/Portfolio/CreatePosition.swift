//
//  CreatePosition.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 10.09.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

/// пикер создается по списку избранных эмиссий если такие есть
/// если нет, то по эмиссиям с потоками
struct SmartEmissionPicker: View {
    @EnvironmentObject var userData: UserData
    @Binding var emissionID: EmissionID
    var error: String
    @State private var selectedEmissionListType = "избранные"
    
    var body: some View {
        let hasFavoriteEmissions = !userData.favoriteEmissions.isEmpty
        
        let emissionIDsWithFlows = userData.flows.map {$0.emissionID}.removingDuplicates()
        
        let emissionsWithFlows = userData.emissions.filter({ emissionIDsWithFlows.contains($0.id) })
        
        return Section(header: Text("Выпуск".uppercased()),
                       footer: Text(error).foregroundColor(.systemRed)){
                        
                        Picker((hasFavoriteEmissions && selectedEmissionListType == "избранные") ? "★" : "◎", selection: $emissionID) {
                            ForEach(emissionsWithFlows.filter({
                                (hasFavoriteEmissions && self.selectedEmissionListType == "избранные") ? (userData.favoriteEmissions[$0.id] ?? false) : true
                            })
                                .sorted(by: { $0.documentRus < $1.documentRus }), id: \.self) { emission in
                                    Text(emission.documentRus).tag(emission.id)
                            }
                        }
                        
                        if hasFavoriteEmissions {
                            Picker(selection: $selectedEmissionListType, label: Text("")) {
                                Text("избранные").tag("избранные")
                                Text("с потоками").tag("с потоками")
                            }
                            .pickerStyle(SegmentedPickerStyle())
                        }
        }
    }
}

struct PortfolioPicker: View {
    @EnvironmentObject var userData: UserData
    @Binding var portfiloID: UUID
    var error: String
    
    var body: some View {
        Section(header: Text("Портфель".uppercased()),
                footer: Text(error).foregroundColor(.systemRed)) {
                    Picker(selection: $portfiloID, label: Text("Портфель")) {
                        ForEach(userData.portfolios, id: \.self) { portfolio in
                            Text(portfolio.name).tag(portfolio.id)
                        }
                    }
        }
    }
}


struct CreatePosition: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var settings: SettingsStore
    
    @State private var emissionID: EmissionID = -1
    @State private var emissionIDError: String = ""
    
    @State private var qty = 1
    
    @State private var portfiloID = UUID()
    @State private var portfiloIDError = ""
    
    @State private var showModal = false
    @State private var modal: ModalType = .portfolioList
    
    var isValidPortfolio: Bool {
        if userData.portfolios.first(where: { $0.id == portfiloID }) == nil {
            portfiloIDError = "Нужно выбрать портфель"
            return false
        } else {
            portfiloIDError = ""
            return true
        }
    }
    
    /// эмиссия должа быть выбрана и такой пары портфель-эмиссия не должно быть в существующих позициях
    var isValidEmission: Bool {
        if userData.emissions.first(where: { $0.id == emissionID }) == nil {
            emissionIDError = "Нужно выбрать эмиссию"
            return false
        } else if userData.positions.first(where: { $0.emissionID == emissionID && $0.portfolioID == portfiloID }) == nil {
            emissionIDError = ""
            return true
        } else {
            emissionIDError = "Такая позиция уже есть в этом портфеле"
            return false
        }
    }
    
    private enum ModalType { case portfolioList, addPortfolio, emissionList, settings }
    
    func showEmissions() {
        modal = .emissionList
        showModal = true
    }
    
    func addPortfolio() {
        modal = .addPortfolio
        showModal = true
    }
    
    func openSettings() {
        presentation.wrappedValue.dismiss()
        modal = .settings
        showModal = true
    }
    
    func savePositionAndDismiss() {
        if self.isValidPortfolio && isValidEmission {
            let position = Position(portfolioID: portfiloID, emissionID: emissionID, qty: qty)
            userData.positions.append(position)
            
            self.presentation.wrappedValue.dismiss()
        }
    }
    
    var body: some View {
        Form {
            if userData.portfolios.isEmpty {
                Section(header: Text("Проблема".uppercased())) {
                    Text("У вас нет ни одного портфеля.")
                        .fixedSize(horizontal: false, vertical: true)
                    Button("Создать портфель") {
                        self.addPortfolio()
                    }
                }
            } else if userData.emissions.isEmpty {
                Section(header: Text("Проблема".uppercased())) {
                    Text("В базе нет ни одного выпуска. Чтобы ввести позицию нужно обновить базу.")
                        .fixedSize(horizontal: false, vertical: true)
                    Button("Перейти к обновлению базы") {
                        self.openSettings()
                    }
                }
            }
            else {
                
                SmartEmissionPicker(emissionID: $emissionID, error: emissionIDError)
                
                Section(header: Text("Количество".uppercased()),
                        footer: Text("")) {
                            Stepper("Количество бумаг \(qty.formattedGrouped)", value: $qty, in: 1...1_000_000)
                }
                
                PortfolioPicker(portfiloID: $portfiloID, error: portfiloIDError)
                
                Section(header: Text("ДОПОЛНИТЕЛЬНО".uppercased()),
                        footer: Text("")) {
                            Button("Создать новый портфель") {
                                self.addPortfolio()
                            }
                            
                            Button("Показать выпуски") {
                                self.showEmissions()
                            }
                }
            }
        }
        .navigationBarTitle("Новая позиция")
            
        .navigationBarItems(
            leading: LeadingButton(name: "Отмена"){
                self.presentation.wrappedValue.dismiss()
            }
            .foregroundColor(.systemRed),
            
            trailing: TrailingButton(name: "Сохранить") {
                self.savePositionAndDismiss()
        })
            
            .sheet(isPresented: $showModal) {
                if self.modal == .addPortfolio {
                    AddPortfolio()
                        .environmentObject(self.userData)
                }
                
                if self.modal == .emissionList {
                    EmissionList()
                        .environmentObject(self.userData)
                        .environmentObject(self.settings)
                }
                
                if self.modal == .settings {
                    NavigationView {
                        Settings()
                    }
                    .environmentObject(self.userData)
                    .environmentObject(self.settings)
                }
        }
    }
}

struct CreatePosition_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Form {
                SmartEmissionPicker(emissionID: .constant(7455), error: "")
            }
            
            NavigationView {
                CreatePosition()
            }
        }
        .environmentObject(SettingsStore())
        .environmentObject(UserData())
        .environment(\.colorScheme, .dark)
    }
}

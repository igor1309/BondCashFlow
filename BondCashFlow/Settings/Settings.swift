//
//  Settings.swift
//  BondsCashFlow
//
//  Created by Igor Malyarov on 25.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct Settings: View {
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var settings: SettingsStore
    
    @State private var isCleaning = false
    @State private var showAlert = false
    @State private var isConfirmed = false
    
    @State private var manyWeeks = 520
    @State private var testButtonName = "Включить тестирование потоков"
    
    func deleteDataAndSettings() {
        if isConfirmed {
            print("about to delete all  data and settings")
            
            //  reset UserData
            userData.reset()
            
            //  reset Settings
            settings.reset()
            
            //  clean UserDefaults
            let domain = Bundle.main.bundleIdentifier!
            UserDefaults.standard.removePersistentDomain(forName: domain)
            UserDefaults.standard.synchronize()
            print("UserDefaults cleaned")
            
            //  clean Document Directory
            let fileManager = FileManager.default
            if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                do {
                    let filePaths = try fileManager.contentsOfDirectory(at: dir, includingPropertiesForKeys: nil, options: [])
                    for filePath in filePaths {
                        try fileManager.removeItem(at: filePath)
                    }
                    print("Document Directory cleaned")
                } catch {
                    print("Could not clear temp folder: \(error)")
                }
            }
        }
    }
    
    var body: some View {
        Form {
            Section(footer: Text("Дата максимально давно и период в \(manyWeeks) недель")) {
                
                Picker("Период", selection: $manyWeeks) {
                    Text("1 год").tag(52)
                    Text("3 года").tag(156)
                    Text("10 лет").tag(520)
                }
                
                Button("Включить тестирование потоков") {
                    self.userData.baseDate = self.userData.calculateCashFlows().map({ $0.date }).min() ?? .distantPast
                    self.settings.startDate = self.userData.calculateCashFlows().map({ $0.date }).min() ?? .distantPast
                    self.settings.weeksToShowInCalendar = self.manyWeeks
                    print("\nвключаю тестирование")
                    print("\(self.userData.baseDate) - baseDate")
                    print("\(self.manyWeeks) - manyWeeks")
                    
                    self.testButtonName = "тестирование включено"
                }
                .disabled(self.testButtonName == "тестирование включено")
            }
            
            Section(header: Text("Сброс".uppercased())) {
                if isCleaning {
                    HStack {
                        RotatingActivityIndicator(text: "очистка…",
                                                  color: .systemGray2)
                    }
                }
                
                Button(action: {
                    self.showAlert = true
                }){
                    Text("Сбросить все настройки и данные")
                }
                .foregroundColor(.systemRed)
                .actionSheet(isPresented: $showAlert) {
                    
                    ActionSheet(title: Text("Удалить всё"),
                                message: Text("Вы точно хотите удалить все данные и настройки без возможности восстановления?"),
                                buttons: [
                                    .cancel(Text("Отмена")),
                                    .destructive(Text("Да, удалить всё!"), action: {
                                        self.isConfirmed = true
                                    })
                    ])
                }
            }
        }
        .navigationBarTitle("Настройки")
            
        .actionSheet(isPresented: $isConfirmed) {
            
            ActionSheet(title: Text("Удалить всё".uppercased()),
                        message: Text("Восстановление невозможно.\nУдалить?".uppercased()),
                        buttons: [
                            .cancel(Text("Отмена")),
                            .destructive(Text("Да, удалить всё!".uppercased()), action: {
                                if self.isConfirmed {
                                    self.isCleaning = true
                                    self.deleteDataAndSettings()
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                        withAnimation(.easeInOut) {
                                            self.isCleaning = false
                                        }
                                    }
                                }
                            })
            ])
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Settings()
                .navigationBarTitle("Настройки")
                .environmentObject(UserData())
                .environmentObject(SettingsStore())
                .environment(\.colorScheme, .dark)
        }
    }
}

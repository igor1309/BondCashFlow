//
//  TotalReset.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 07.09.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct TotalReset: View {
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var settings: SettingsStore
    
    @State private var isConfirmed = false
    @State private var isCleaning = false
    @State private var isDoneCleaning = false
    @State private var showAlert = false
    
    func deleteEverything() {
        if self.isConfirmed {
            self.isCleaning = true
            self.isDoneCleaning = false
            
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
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                withAnimation(.easeInOut) {
                    self.isCleaning = false
                    self.isDoneCleaning = true
                }
            }
        } else {
            self.isConfirmed = true
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.warning)
        }
    }
    
    var body: some View {
        Section(header: Text("Сброс".uppercased()),
                footer: Text("Удаление всех данных и настроек.")) {
                    if isDoneCleaning {
                        DisappearingText(text: "Сброс завершен", isShown: $isDoneCleaning)
                    }
                    
                    HStack {
                        
                        if isCleaning {
                            RotatingActivityIndicator(text: "очистка…",
                                                      color: .systemGray2)
                        }
                        
                        Button(action: {
                            self.showAlert = true
                        }){
                            Text(isCleaning ? "" : "Сбросить все настройки и данные")
                        }
                        .foregroundColor(.systemRed)
                        .actionSheet(isPresented: $showAlert) {
                            
                            ActionSheet(title: Text("Удалить всё"),
                                        message: Text("Вы точно хотите удалить все данные и настройки без возможности восстановления?"),
                                        buttons: [
                                            .cancel(Text("Отмена")),
                                            .destructive(Text("Да, удалить всё!"), action: {
                                                self.deleteEverything()
                                            })
                            ])
                        }
                    }
        }
        .actionSheet(isPresented: $isConfirmed) {
            ActionSheet(title: Text("Удалить всё".uppercased()),
                        message: Text("Восстановление невозможно.\nУдалить?".uppercased()),
                        buttons: [
                            .cancel(Text("Отмена")),
                            .destructive(Text("Да, удалить всё!".uppercased()), action: {
                                self.deleteEverything()
                            })
            ])
        }
    }
}

struct TotalReset_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TotalReset()
                .navigationBarTitle("Настройки")
        }
        .environmentObject(UserData())
        .environmentObject(SettingsStore())
        .environment(\.colorScheme, .dark)
        
    }
}

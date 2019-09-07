//
//  BackupAndDummy.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 06.09.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct DisappearingText: View {
    var text: String
    @Binding var isShown: Bool
    
    var body: some View {
        Text(text)
            .fixedSize(horizontal: false, vertical: true)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    withAnimation(.easeInOut) {
                        self.isShown = false
                    }
                }
        }
    }
}


struct BackupAndDummy: View {
    @EnvironmentObject var userData: UserData
    @State private var isRestorationSuccessful = false
    @State private var isNoBackup = false
    @State private var isTestPositionsLoaded = false
    @State private var isErrorCreatingTestPositions = false
    @State private var showActionRestore = false
    @State private var showActionTest = false
    
    func restorePositions() {
        if userData.restorePositionsFromBackup() {
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
            
            isRestorationSuccessful = true
        } else {
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)
            
            isNoBackup = true
        }
    }
    
    func loadTestPositions() {
        if userData.loadTestPositions() {
            
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
            
            isTestPositionsLoaded = true
        } else {
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)
            
            isErrorCreatingTestPositions = true
        }
    }
    
    var body: some View {
        Section(header: Text("Тест".uppercased()),
                footer: Text("Тестовые позиции заменят текущие позиции. Тестовые позиции генерируются псевдо-случайным образом. Текущие позиции будут сохранены в резервной копии, из которой их потом можно будет восстановить.")) {
                    Group {
                        if isTestPositionsLoaded {
                            DisappearingText(text: "Позиции заменены на тестовые", isShown: $isTestPositionsLoaded)
                        }
                        if isErrorCreatingTestPositions {
                            DisappearingText(text: "Не удалось создать тестовые позиции — обновите локальную базу.", isShown: $isErrorCreatingTestPositions)
                                .foregroundColor(.systemRed)
                        }
                        
                        Button(action: {
                            self.showActionTest = true
                        }){
                            HStack {
                                Text("Сгенерировать тестовые позиции")
                                Image(systemName: "bandage")
                            }
                        }
                        .actionSheet(isPresented: $showActionTest) {
                            ActionSheet(title: Text("Тестовые позиции"),
                                        message: Text("Заменить текущие позиции на тестовые?\nЭту операцию отменить невозможно."),
                                        buttons: [
                                            .cancel(Text("Отмена")),
                                            .destructive(Text("Да, заменить на тестовые")) {
                                                self.loadTestPositions()
                                            }
                            ])
                        }
                    }
                    
                    Group {
                        
                        if isRestorationSuccessful {
                            DisappearingText(text: "Позиции восстановлены", isShown: $isRestorationSuccessful)
                        }
                        
                        if isNoBackup {
                            DisappearingText(text: "Позиции восстановить не удалось", isShown: $isNoBackup)
                                .foregroundColor(.systemRed)
                        }
                        
                        Button(action: {
                            self.showActionRestore = true
                        }){
                            HStack {
                                Text("Восстановить позиции")
                                Image(systemName: "gobackward")
                            }
                        }
                        .actionSheet(isPresented: $showActionRestore) {
                            ActionSheet(title: Text("Восстановить позиции"),
                                        message: Text("Восстановить позиции из резервной копии?\nЭту операцию отменить невозможно."),
                                        buttons: [
                                            .cancel(Text("Отмена")),
                                            .destructive(Text("Да, восстановить")) {
                                                self.restorePositions()
                                            }
                            ])
                        }
                    }
        }
    }
}

struct BackupAndDummy_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Form {
                BackupAndDummy()
            }
            .navigationBarTitle("Настройки")
        }
        .environmentObject(UserData())
    }
}

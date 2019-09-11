//
//  DataBaseView.swift
//  BondsCashFlow
//
//  Created by Igor Malyarov on 25.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct DataBaseView: View {
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var settings: SettingsStore
    
    @State private var manyWeeks = 156
    @State private var testPeriodButtonName = "Увеличить период для потоков"
    @State private var testButtonName = "Включить тестирование потоков"
    
    var body: some View {
        Form {
            LocalDataSection()
            
            CBondsSection()
                .environmentObject(self.userData)
            
            BackupAndDummy()
            
            Section(header: Text("Период для потоков".uppercased()),
                    footer: Text("Изменить период расчета потоков до \(manyWeeks) недель (стандартный — 52).")) {
                        
                        Picker("Период", selection: $manyWeeks) {
                            Text("1 год").tag(52)
                            Text("3 года").tag(156)
                            Text("10 лет").tag(520)
                        }
                        
                        Button(testPeriodButtonName) {
                            #if DEBUG
                            self.settings.weeksToShowInCalendar = self.manyWeeks
                            
                            print("\nвключаю увеличение периода расчета потоков")
                            
                            self.testPeriodButtonName = "Период увеличен до \(self.manyWeeks) недель"
                            let generator = UINotificationFeedbackGenerator()
                            generator.notificationOccurred(.warning)
                            #endif
                        }
                        .disabled(self.testPeriodButtonName == "Период увеличен до \(self.manyWeeks) недель")
            }
            
            TotalReset()
            
            Section(header:
                Text("DEV ONLY")
                    .font(.headline)
                    .foregroundColor(.systemRed)
                    .fontWeight(.black),
                    footer:
            Text("Дата максимально давно и период в \(manyWeeks) недель (определён в разделе ПЕРИОД ДЛЯ ПОТОКОВ).")) {
                
                Button(testButtonName) {
                    #if DEBUG
                    self.userData.baseDate = self.userData.calculateCashFlows().map({ $0.date }).min()?.firstDayOfWeekRU.startOfDay ?? .distantPast
                    self.settings.startDate = self.userData.calculateCashFlows().map({ $0.date }).min()?.firstDayOfWeekRU.startOfDay ?? .distantPast
                    self.settings.weeksToShowInCalendar = self.manyWeeks
                    
                    print("\nвключаю тестирование")
                    print("\(self.userData.baseDate) - baseDate")
                    print("\(self.manyWeeks) - manyWeeks")
                    
                    self.testButtonName = "Тестирование включено"
                    let generator = UINotificationFeedbackGenerator()
                    generator.notificationOccurred(.warning)
                    #endif
                }
                .disabled(self.testButtonName == "Тестирование включено")
                .foregroundColor(.systemRed)
            }
        }
        .navigationBarTitle("Локальная база")
    }
}

struct DataBaseView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DataBaseView()
                .navigationBarTitle("Настройки")
        }
        .environmentObject(UserData())
        .environmentObject(SettingsStore())
        .environment(\.colorScheme, .dark)
    }
}

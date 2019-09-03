//
//  LocalDataSection.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 02.09.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct LocalDataSection: View {
    @EnvironmentObject var userData: UserData
    @State private var showModal = false
    
    var body: some View {
        Section(header: Text("Локальная база".uppercased())
        ){
            Group {
                VStack(alignment: .leading, spacing: 3) {
                    Text("В базе всего:").bold()
                    
                    VStack(alignment: .leading) {
                        Text("Выпусков: " + userData.emissions.count.formattedGrouped)
                        Text("Эмитентов: " + userData.emissions.map({ $0.emitentID }).removingDuplicates().count.formattedGrouped)
                    }
                    .padding(.leading)
                }
                
                VStack(alignment: .leading, spacing: 3) {
                    if userData.flowMetadata != nil {
                        Text("Потоки:").bold()
                        
                        VStack(alignment: .leading) {
                            Text("Обновлены: " + (userData.flowMetadata?.update.toString(format: "dd.MM.yyyy"))! + " в " + (userData.flowMetadata?.update.toString(format: "HH:mm"))!)
                            Text("В локальной базе: " + (userData.flowMetadata?.count.formattedGrouped)!)
                            Text("(в базе cbonds.ru: " + (userData.flowMetadata?.total.formattedGrouped)! + ")")
                        }
                        .padding(.leading)
                    } else {
                        Text("Информация по потокам не обновлена")
                    }
                }
                
                VStack(alignment: .leading, spacing: 3) {
                    if userData.emissionMetadata != nil {
                        Text("Эмиссии:").bold()
                        
                        VStack(alignment: .leading) {
                            Text("Обновлены: " + (userData.emissionMetadata?.update.toString(format: "dd.MM.yyyy"))! + " в " + (userData.emissionMetadata?.update.toString(format: "HH:mm"))!)
                            Text("В локальной базе: " + (userData.emissionMetadata?.count.formattedGrouped)!)
                            Text("(в базе cbonds.ru: " + (userData.emissionMetadata?.total.formattedGrouped)! + ")")
                        }
                        .padding(.leading)
                    } else {
                        Text("Информация по выпускам не обновлена")
                    }
                }
            }
            .foregroundColor(.secondary)
            .font(.footnote)
            
            Button(action: {
                self.showModal = true
            }) {
                Text("Показать выпуски")
            }
        }
            
        .sheet(isPresented: $showModal,
               content: {
                EmissionList(local: true)
                    .environmentObject(self.userData)
        })
    }
}

struct LocalDataSection_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Form {
                LocalDataSection()
                    .environmentObject(UserData())
            }
        }
    }
}

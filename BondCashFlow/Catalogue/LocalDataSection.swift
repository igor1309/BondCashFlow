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
                    Text("В базе всего:")
                    
                    VStack(alignment: .leading) {
                        Text("Выпусков:" + userData.emissions.count.formattedGrouped)
                        Text("Эмитентов: " + userData.emissions.map({ $0.emitentID }).removingDuplicates().count.formattedGrouped)
                    }
                    .padding(.leading)
                }
                
                VStack(alignment: .leading, spacing: 3) {
                    if userData.cbondEmissionMetadata != nil {
                        Text("Эмиссии:")
                        
                        VStack(alignment: .leading) {
                            Text("Выпусков в локальной базе: " + (userData.cbondEmissionMetadata?.count.formattedGrouped)!)
                            Text("(выпусков в базе cbonds.ru: " + (userData.cbondEmissionMetadata?.total.formattedGrouped)! + ")")
                            Text("Дата обновления: " + (userData.cbondEmissionMetadata?.update.toString(format: "dd.MM.yyyy HH:ss"))!)
                        }
                        .padding(.leading)
                    } else {
                        Text("Информация по выпускам не обновлена")
                    }
                }
                
                VStack(alignment: .leading, spacing: 3) {
                    if userData.cbondFlowMetadata != nil {
                        Text("Потоки:")
                        
                        VStack(alignment: .leading) {
                            Text("Потоков в локальной базе: " + (userData.cbondFlowMetadata?.count.formattedGrouped)!)
                            Text("(потоков в базе cbonds.ru: " + (userData.cbondFlowMetadata?.total.formattedGrouped)! + ")")
                            Text("Дата обновления: " + (userData.cbondFlowMetadata?.update.toString(format: "dd.MM.yyyy HH:ss"))!)
                        }
                        .padding(.leading)
                    } else {
                        Text("Информация по потокам не обновлена")
                    }
                }
            }
            .foregroundColor(.secondary)
            .font(.footnote)
            
            Button(action: {
                self.showModal = true
            }) {
                Text("Показать выпуски в локальной базе")
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

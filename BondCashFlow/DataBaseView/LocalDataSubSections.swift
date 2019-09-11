//
//  LocalDataSubSections.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 04.09.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct LocalStoreInfo: View {
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var settings: SettingsStore
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text("В базе всего:").bold()
            
            HStack(alignment: .firstTextBaseline) {
                Text("Выпусков: " + userData.emissions.count.formattedGrouped)
                Spacer()
                Text("Эмитентов: " + userData.emissions.map({ $0.emitentID }).removingDuplicates().count.formattedGrouped)
            }
            .padding(.horizontal)
            .onTapGesture {
                self.settings.isLocalStoreShowMore.toggle()
            }
        }
    }
}

struct FlowsMetadata: View {
    @EnvironmentObject var userData: UserData
    
    var body: some View {
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
                Text("Информация по потокам отсутствует")
            }
        }
    }
}

struct EmissionsMetadata: View {
    @EnvironmentObject var userData: UserData
    
    var body: some View {
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
                Text("Информация по выпускам отсутствует")
            }
        }
        
    }
}

struct LocalDataSubSections_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Form {
                
                LocalStoreInfo()//showMore: .constant(false))
                
                FlowsMetadata()
                
                EmissionsMetadata()
                
            }
        }
        .environmentObject(UserData())
        .environmentObject(SettingsStore())
    }
}

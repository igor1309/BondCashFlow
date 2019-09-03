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
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text("В базе всего:").bold()
            
            VStack(alignment: .leading) {
                Text("Выпусков: " + userData.emissions.count.formattedGrouped)
                Text("Эмитентов: " + userData.emissions.map({ $0.emitentID }).removingDuplicates().count.formattedGrouped)
            }
            .padding(.leading)
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
                Text("Информация по потокам не обновлена")
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
                Text("Информация по выпускам не обновлена")
            }
        }
        
    }
}

struct LocalDataSubSections_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Form {
                
                LocalStoreInfo()
                
                FlowsMetadata()
                
                EmissionsMetadata()
                
            }
        }
        .environmentObject(UserData())
    }
}

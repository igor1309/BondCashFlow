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
        //  MARK: TODO: нужна дополнительная инфлрмация по базе (обновления и прочее)
        //  метаданные!
        Section(header: Text("Локальная база".uppercased())
        ){
            Text("В базе всего: \(userData.emissions.count.formattedGrouped) выпусков, \(userData.emissions.map({ $0.emitentID }).removingDuplicates().count.formattedGrouped) эмитентов.")
                //  MARK: - одна из опций должна работать - не обрезать текст
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
                .foregroundColor(.secondary)
                .font(.subheadline)
            
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

//
//  EmissionList.swift
//  BondsCashFlow
//
//  Created by Igor Malyarov on 27.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

enum FilterType: String, CaseIterable {
    case all = "все эмиссии"
    case withFlows = "только эмиссии с потоками"
    case favorites = "★ избранные"
    //  MARK: TODO додумать и доделать
    case emitent = "фильтр по эмитенту"
    case byText = "текстовый фильтр"
}

struct EmissionList: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var userData: UserData
    
    var local = true
    
    @State private var filter: String = ""
    @State private var filterType: FilterType = .favorites
    
    @State private var showFilter = false
    
    //  MARK: TODO доделать
    //  MARK: TODO заменить на метаданные
    @State private var emissionsCount: Int = loadEmissionData().count
    @State private var emitemtsCount: Int = loadEmissionData().map({ $0.emitentID }).removingDuplicates().count
    
    var body: some View {
        
        NavigationView {
            VStack(alignment: .leading) {
                VStack(alignment: .leading, spacing: 3) {
                    Text(filterType == .all ? filterType.rawValue : "Фильтр: " + filterType.rawValue)
                        .foregroundColor(.secondary)
                        .font(.caption)
                        .padding(.horizontal)
                    
                    //  MARK: TODO доделать
                    Text("TBD: … выпуск/а/ов, … эмитент/а/ов")
                        .foregroundColor(.systemTeal)
                        //                Text("\(emissionsCount.formattedGrouped) выпуск/а/ов, \(emitemtsCount.formattedGrouped) эмитент/а/ов")
                        //                    //  MARK: - одна из опций должна работать (не обрезать текст)
                        //                    .lineLimit(nil)
                        //                    .fixedSize(horizontal: false, vertical: true)
                        //                    .foregroundColor(.secondary)
                        .font(.caption)
                        .padding(.horizontal)
                }
                
                List {
                    ForEach(userData.emissions.filter({
                        
                        switch filterType {
                        case .all:
                            return true
                        case .emitent:
                            return $0.emitentNameRus == filter
                        case .byText:
                            return $0.documentRus.contains(filter) ||
                                $0.documentRus.contains(filter.uppercased()) ||
                                $0.documentRus.contains(filter.lowercased()) ||
                                $0.documentRus.contains(filter.capitalized) ||
                                $0.isinCode.contains(filter) ||
                                $0.isinCode.contains(filter.uppercased()) ||
                                $0.isinCode.contains(filter.lowercased()) ||
                                $0.isinCode.contains(filter.capitalized) ||
                                $0.id == Int(filter) ?? -1
                        case .withFlows:
                            return userData.flows.map { $0.emissionID }.contains($0.id)
                        case .favorites:
                            return userData.favoriteEmissions[$0.id] ?? false
                        }
                        
                    }).sorted(by: {
                        (($0.emitentNameRus, $0.documentRus, $0.isinCode)
                            < ($1.emitentNameRus, $0.documentRus, $1.isinCode))
                    }), id: \.self) { emission in
                        
                        EmissionRow(emission: emission)
                    }
                }
            }
            .navigationBarTitle("Эмиссии")
                
            .navigationBarItems(
                leading: Button(action: {
                    self.showFilter = true
                }) {
                    Image(systemName: filterType == FilterType.all ? "line.horizontal.3.decrease.circle" : "line.horizontal.3.decrease.circle.fill")
                    //                        .imageScale(.large)
                },
                
                
                trailing: TrailingButton(name: "Закрыть", closure: {
                    self.presentation.wrappedValue.dismiss()
                })
            )
                
                //  по свайпу закрывания модала работает
                //  фильт меняется и didSet происходит
                //  и обновляется таблица, но
                //  не работает когда в EmitentFilter вызывается self.presentation.wrappedValue.dismiss()
                //  либо баг либо нет
                //  решения пока не видно
                .sheet(isPresented: $showFilter,
                       onDismiss: {  },
                       content: { EmitentFilter(filterType: self.$filterType,
                                                filter: self.$filter)
                        .environmentObject(self.userData)
                })
        }
    }
}

struct EmissionList_Previews: PreviewProvider {
    static var previews: some View {
        EmissionList()
            .environmentObject(UserData())
    }
}

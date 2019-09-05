//
//  EmissionList.swift
//  BondsCashFlow
//
//  Created by Igor Malyarov on 27.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct EmissionList: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var settings: SettingsStore
    @EnvironmentObject var userData: UserData
    
    var local = true
    
    @State private var filter: String = ""
    @State private var filterType: FilterType = .favorites
    
    
    //  MARK: хотелось бы сохранять выбранный фильтр в selectedFilter в SettingsStore
    //  но как это делать???
    //    init(local: Bool = true) {
    //        self.local = local
    //        self._filterType = State(initialValue: FilterType(rawValue: settings.selectedFilter) ?? .favorites)
    //    }
    
    @State private var showFilter = false
    
    //  MARK: TODO доделать
    //  MARK: TODO заменить на метаданные
    @State private var emissionsCount: Int = loadEmissionData().count
    @State private var emitemtsCount: Int = loadEmissionData().map({ $0.emitentID }).removingDuplicates().count
    
    var body: some View {
        
        NavigationView {
            VStack(alignment: .leading) {
                //                VStack(alignment: .leading, spacing: 3) {
                HStack {
                    // Text(filterType == .all ? filterType.rawValue : "Фильтр: " + filterType.rawValue)
                    Text(filterType.rawValue)
                        .foregroundColor(.secondary)
                        .font(.caption)
                        .padding(.horizontal)
                    
                    Spacer()
                    
                    HStack {
                        //  MARK: TODO доделать
                        Text("Выпусков …")
                        Text("Эмитентов …")
                        //                Text("\(emissionsCount.formattedGrouped) выпуск/а/ов, \(emitemtsCount.formattedGrouped) эмитент/а/ов")
                        //                    //  MARK: - одна из опций должна работать (не обрезать текст)
                        //                    .lineLimit(nil)
                        //                    .fixedSize(horizontal: false, vertical: true)
                        //                    .foregroundColor(.secondary)
                    }
                    .foregroundColor(.systemTeal)
                    .font(.caption)
                    .padding(.horizontal)
                }
                .contextMenu {
                    if filterType != .all {
                        Button(action: {
                            self.filterType = .all
                        }) {
                            HStack {
                                Image(systemName: "sun.max")
                                Spacer()
                                Text("все выпуски")
                            }
                        }
                    }
                    
                    if filterType != .withFlows {
                        Button(action: {
                            self.filterType = .withFlows
                        }) {
                            HStack {
                                Image(systemName: "flowchart")
                                Spacer()
                                Text("выпуски с потоками")
                            }
                            
                        }
                    }
                    
                    if filterType != .favorites {
                        Button(action: {
                            self.filterType = .favorites
                        }) {
                            HStack {
                                Image(systemName: "star")
                                Spacer()
                                Text("избранные выпуски")
                            }
                        }
                    }
                }
                
                List {
                    ForEach(userData.emissions.filter({
                        
                        switch filterType {
                        case .all:
                            return true
                        case .withFlows:
                            return userData.flows.map { $0.emissionID }.contains($0.id)
                        case .emitent:
                            return $0.emitentNameRus == filter
                        case .favorites:
                            return userData.favoriteEmissions[$0.id] ?? false
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
            .environmentObject(SettingsStore())
    }
}

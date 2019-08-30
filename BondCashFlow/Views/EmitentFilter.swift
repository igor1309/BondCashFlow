//
//  EmitentFilter.swift
//  BondsCashFlow
//
//  Created by Igor Malyarov on 27.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct EmitentFilter: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var userData: UserData
    
    @Binding var filterType: FilterType
    @Binding var filter: String
    
    @State var preFilterType: FilterType
    @State var preFilter: String
    
    init(filterType: Binding<FilterType>, filter: Binding<String>) {
        self._filterType = filterType
        self._filter = filter
        
        self._preFilterType = State(initialValue: filterType.wrappedValue)
        self._preFilter = State(initialValue: filter.wrappedValue)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Варианты".uppercased())
                ){
                    Picker(selection: $preFilterType, label: Text("")) {
                        ForEach(FilterType.allCases, id: \.self) { type in
                            Text(type.rawValue).tag(type)
                        }
                    }
                }
                
                if preFilterType == FilterType.byText {
                    
                    Section(footer: Text("такой поиск занимает время")
                    ){
                        
                        TextField("Фильтр по названию выпуска, ISIN",
                                  text: $preFilter,
                                  onEditingChanged: { isEdited in
                        },
                                  onCommit:
                            {
                        })
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                } else if preFilterType == FilterType.emitent {
                    
                    Section(header: Text("Эмитент".uppercased())
                    ){
                        Picker(selection: $preFilter, label: Text("")//Фильтр по эмитенту")
                        ){
                            ForEach(userData.emitents, id: \.self){ name in
                                Text(name).tag(name)
                            }
                        }
                    }
                }
            }
                
                
            .navigationBarTitle("Фильтр")
                
            .navigationBarItems(trailing: Button(action: {
                self.presentation.wrappedValue.dismiss()
                self.filterType = self.preFilterType
                self.filter = self.preFilter
            }) {
                Text("Закрыть")
            })
            
        }
    }
}

struct EmitentFilter_Previews: PreviewProvider {
    static var previews: some View {
        EmitentFilter(filterType: .constant(FilterType.byText),
                      filter: .constant(""))
            .environmentObject(UserData())
    }
}

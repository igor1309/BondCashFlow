//
//  Catalogue.swift
//  BondsCashFlow
//
//  Created by Igor Malyarov on 25.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct Catalogue: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var userData: UserData
    
    @State private var showModal = false
    @State private var modal: Modal = .credentials
    
    private enum Modal {
        case credentials, emitentsLocal
    }
    
    
    //  MARK: - change to userdata, store if changed
    //  MARK: use hash to store password
    @State private var login: String = "test"
    @State private var password: String = "test"
    
    //  MARK: - change to userdata, store if changed (UserDefaults)
    @State private var cbondOperation = "get_emissions"//"get_flow"  // get_emissions
    @State private var cbondLimit = 10
    @State private var cbondOffset = 0
    
    @State private var showConfirm = false
    
    @State private var process = ""
    
    var isinFilterString: String {
        
        return ""
        
        //  MARK: fix this: no more isins in positions
//        let isins = userData.portfolios.flatMap{ $0.positions }.map{ $0.isin }.removingDuplicates()
//        let isinsString = isins.reduce(""){ $0 + $1 + ", "}.dropLast(2)
//        
//        if isins.count == 1 {
//            return "\"filters\":[{\"field\":\"isin_code\",\"operator\":\"eq\",\"value\":\"\(isinsString)\"}],"
//        }
//        if isins.count > 1 {
//            return "\"filters\":[{\"field\":\"isin_code\",\"operator\":\"in\",\"value\":\"\(isinsString)\"}],"
//        } else {
//            return ""
//        }
    }
    
    
    var body: some View {
        Form {
            Section(header: Text("Локальная база".uppercased())
                ){
            Text("В базе всего: \(userData.emissions.count.formattedGrouped) выпусков, \(userData.emissions.map({ $0.emitentID }).removingDuplicates().count.formattedGrouped) эмитентов.")
                //  MARK: - одна из обций должна работать - не обрезать текст
                    .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
            .foregroundColor(.secondary)
            .font(.subheadline)
            
            Button(action: {
                self.modal = .emitentsLocal
                self.showModal = true
            }) {
                Text("Выпуски в локальной базе")
            }
        }
            
            Section(header: Text("cbonds.ru".uppercased()),
                    footer: Text("")
            ){
                HStack {
                    Text("Логин-пароль")
                    
                    Spacer()
                    
                    Text("\(login):\(password)")
                }
                .onTapGesture {
                    self.modal = .credentials
                    self.showModal = true
                }
                
                Picker(selection: $cbondOperation, label: Text("Операция")) {
                    Text("Потоки").tag("get_flow")
                    Text("Эмиссии").tag("get_emissions")
                }
                
                Picker(selection: $cbondLimit, label: Text("Лимит запроса")) {
                    Text("1").tag(1)
                    Text("10").tag(10)
                    Text("50").tag(50)
                    Text("100").tag(100)
                    Text("500").tag(500)
                    Text("1000").tag(1000)
                }
                
                Picker(selection: $cbondOffset, label: Text("Сдвиг")) {
                    Text("0").tag(0)
                    Text("10").tag(10)
                    Text("50").tag(50)
                    Text("100").tag(100)
                    Text("500").tag(500)
                    Text("1000").tag(1000)
                }
                
                
            }
            
            Section(footer: Text("Можно обновить все справочники или только по выпускам в портфелях.")
            ){
                
                Button(action: {
                    self.showConfirm = true
                }) {
                    Text("Обновить справочники")
                }
            }
        }
        .navigationBarTitle("Справочники")
            
        .navigationBarItems(trailing: Button(action: {
            self.modal = .credentials
            self.showModal = true
        }) {
            Image(systemName: "pencil.and.ellipsis.rectangle")
                .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 0))
        })
            
            .actionSheet(isPresented: $showConfirm, content: { () -> ActionSheet in
                ActionSheet(title: Text("Обновить справочники"),
                            message: Text("Полное обновление может занять время на получение данных и обработку."),
                            buttons: [
                                .cancel(Text("Отмена")),
                                .destructive(Text("Обновить всё сейчас"), action: {
                                    //  MARK: - TODO:
                                }),
                                .destructive(Text("Обновить \(self.cbondOperation == "get_emissions" ? "Эмиссии" : "Потоки") сейчас"), action: {
                                    //   MARK:- request data and save to file
                                    self.process = "Отправка запроса…"
                                    //                                    print("filters: \(self.isinFilterString)")
                                    do {
                                        try cbondFetch(login: self.login,
                                                       password: self.password,
                                                       filters: "",//self.isinFilterString,
                                            limit: self.cbondLimit,
                                            offset: self.cbondOffset,
                                            cbondOperation: self.cbondOperation)
                                        //                                        self.process = "Данные получены"
                                    } catch {
                                        self.process = "Error getting data fron CBond."
                                    }
                                    
                                    
                                    //  запросить cbonds
                                    
                                    //                                    self.process = "Получение данных…"
                                    
                                    //                                    self.process = "Обработка…"
                                    
                                    //                                    self.process = "Сохранение данных…"
                                    
                                    
                                }),
                                .default(Text("Всё по выпускам в портфелях"), action: {
                                    //  MARK: - TODO:
                                }),
                                //  MARK: - TODO: do it: background operation
                                .default(
                                    Text("Всё, но позже"), action: {
                                        //   MARK:- request data and save to file
                                })
                ])
            })
            
            .sheet(isPresented: $showModal,
                   
                   //   MARK: - change to userdata
                //  MARK: use hash to store password
                //  MARK: - TODO: prevent dismiss by swipe with empty fields
                content: {
                    if self.modal == .credentials {
                        CbondLogin(login: self.$login, password: self.$password)
                    }
                    
                    if self.modal == .emitentsLocal {
                        EmissionList(local: true).environmentObject(self.userData)
                    }
            })
    }
}
struct Catalogue_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Catalogue()
                .environmentObject(UserData())
        }
    }
}

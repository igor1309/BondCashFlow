//
//  UpdateLocalDataSection.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 02.09.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct UpdateLocalDataSection: View {
    @EnvironmentObject var userData: UserData
    
    //  MARK: - change to userdata, store if changed
    //  MARK: use hash to store password
    var login: String
    var password: String
    
    //  MARK: - change to userdata, store if changed (UserDefaults)
    var cbondOperation: String
    var cbondLimit: Int
    var cbondOffset: Int
    
    
    var isinFilterString: String {
        
        return ""
        
        //  MARK: TODO fix this: no more isins in positions
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
    
    
    @State private var showConfirmation = false

    //  MARK: Networking
    @State private var process = ""
    @State private var isLoading = false
    @State private var isFinished = false
    @State private var showAlert = false
    @State private var alertMessage = ""

    func requestCompletedOK() {
        self.isLoading = false
        self.process = "Загрузка завершена."
        withAnimation(.easeInOut) {
            self.isFinished = true
        }
        
        //  MARK: TODO uodate emissions and flows in userData!!!!!
    }
    
    func handleCBondError(_ error: Error) {
        print("handleCBondError:")
        print(error)
        self.isLoading = false
        self.isFinished = false
        self.alertMessage = "Проверьте, пожалуйста, логин-пароль или обратитесь к разработчику.\n\nСообщение системы:\n" + error.localizedDescription
        self.showAlert = true
        self.process = "Ошибка получения данных CBond."
    }
        
    var body: some View {
        Group {
            if isFinished {
                Text(process)
                    .foregroundColor(.secondary)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                            withAnimation(.easeInOut) {
                                self.isFinished = false
                            }
                        }
                }
            }
            
            HStack {
                if isLoading {
                    HStack {
                        RotatingActivityIndicator(text: "загрузка и обработка данных…",
                                                  color: .systemGray2)
                    }
                }
                
                Button(action: {
                    self.showConfirmation = true
                }) {
                    Text(isLoading ? "" : "Обновить справочники")
                }
                .disabled(isLoading)
            }
        }
            
        .alert(isPresented: $showAlert, content: {
            Alert(title: Text("Ошибка получения данных CBond"),
                  message: Text(self.alertMessage),
                  dismissButton: .default(Text("OK"), action: {}))
        })
            
        .actionSheet(isPresented: $showConfirmation, content: {
            ActionSheet(title: Text("Обновить справочники"),
                        message: Text("Полное обновление может занять время на получение данных и обработку."),
                        buttons: [
                            .cancel(
                                Text("Отмена")),
                            .destructive(
                                Text("Обновить всё сейчас"),
                                action: { self.loadEverything() }),
                            .destructive(
                                Text("Обновить \(self.cbondOperation == "get_emissions" ? "Эмиссии" : "Потоки") сейчас"),
                                action: { self.loadSelectedCBondOperation() }),
                            .default(
                                Text("Избранные и в портфелях"),
                                action: { self.loadSelects() }),
                            .default(
                                Text("Всё, но позже"),
                                action: { self.loadInBackground() })
            ])
        })
        
    }
    
    //  MARK: - TODO
    private func loadEverything() {
        self.isLoading = true
        self.isFinished = false
        
        do {
            try self.cbondSmartFetch(login: self.login,
                                     password: self.password,
                                     filters: "",
                                     limit: self.cbondLimit,
                                     offset: self.cbondOffset,
                                     cbondOperation: self.cbondOperation)
        } catch let error {
            self.handleCBondError(error)
        }
        
    }
    
    private func loadSelectedCBondOperation() {
        //  MARK: - TODO:
        self.isLoading = true
        self.isFinished = false
        
        do {
            //self.isinFilterString,
            try self.cbondFetch(login: self.login,
                                password: self.password,
                                filters: "",
                                limit: self.cbondLimit,
                                offset: self.cbondOffset,
                                cbondOperation: self.cbondOperation)
        } catch let error {
            self.handleCBondError(error)
        }
    }
    
    //  MARK: - TODO: filters!!!
    private func loadSelects() {    //  Избранные и в портфелях
        //  MARK: TODO
    }
    
    //  MARK: - TODO: do it: background operation
    private func loadInBackground() {
        //  MARK: TODO request data and save to file
    }
}

struct UpdateLocalDataSection_Previews: PreviewProvider {
    static var previews: some View {
        UpdateLocalDataSection(login: "test", password: "test", cbondOperation: "get_emissions", cbondLimit: 50, cbondOffset: 0)
    }
}

//
//  PortfolioList.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 01.09.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct PortfolioList: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var userData: UserData
    
    private func delete(at offsets: IndexSet) {
        if let first = offsets.first {
            //  MARK: вставить проверку на наличие транзакций с этим портфелем
            //  и не удалять если есть!!
            userData.portfolioNames.remove(at: first)
        }
    }
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 8) {
                Text("ВНИМАНИЕ\nНе удалять портфели!\nПоскольку проверка наличия транзакций еще не реализована, целостность базы при удалени может быть повреждена.")
                    .foregroundColor(.systemRed)
                    .fontWeight(.bold)
                    .padding()
                
                List {
                    ForEach(userData.portfolioNames, id: \.self) { name in
                        Text(name)
                    }
                    .onDelete(perform: delete)
                }
            }
                
            .navigationBarTitle("Портфели")
                
            .navigationBarItems(
                leading: EditButton(),
                
                trailing: Button(action: {
                    self.presentation.wrappedValue.dismiss()
                }) {
                    Text("Закрыть")
                        .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 0))
                    
            })
        }
    }
}


struct PortfolioList_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioList()
            .environmentObject(UserData())
    }
}

//
//  CFCalendar.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 24.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct CFCalendar: View {
    @EnvironmentObject var userData: UserData
    @State private var showPortfolioFilter = false
    
    var body: some View {
        CashFlowView()
            
            .navigationBarTitle("Потоки")
            
            .navigationBarItems(leading:
                Button(action: {
                    self.showPortfolioFilter = true
                }) {
                    //  MARK: TODO добавить
                    //  MARK: TODO нужно сменить логику фильра иначе непонятно, когда фильтр применён
                    //  ввести @State var … : Bool
                    //  Image(systemName: <<Bool>> ? "briefcase" : "briefcase.fill")
                    Image(systemName: userData.isAllPortfoliosSelected ? "briefcase" : "briefcase.fill")
                        .padding(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 16))
                }
                    //            .imageScale(.large)
                    .disabled(!self.userData.hasAtLeastTwoPortfolios))
            
            .sheet(isPresented: $showPortfolioFilter,
                   content: { PotfolioFilter().environmentObject(self.userData) })
    }
}

struct CFCalendar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CFCalendar()
                .environmentObject(UserData())
        }
    }
}

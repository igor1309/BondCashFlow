//
//  ContentView.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 24.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var settings: SettingsStore
    
    var body: some View {
        TabView(selection: $settings.lastTabUsed){
            
            NavigationView {
                MainPortfolioView()
            }
            .tabItem {
                VStack {
                    Image(systemName: "briefcase")
                    Text("Портфели")
                }
            }
            .tag(0)
            
            NavigationView {
                CashFlowTable()
            }
            .tabItem {
                VStack {
                    Image(systemName: "flowchart")
                    Text("Потоки")
                }
            }
            .tag(1)
            
            NavigationView {
                Emissions()
            }
            .tabItem {
                VStack {
                    Image(systemName: "tray.2.fill")
                    Text("Выпуски")
                }
            }
            .tag(2)
            
            NavigationView {
                CFCalendar()
            }
            .tabItem {
                VStack {
                    Image(systemName: "calendar")
                    Text("Календарь")
                }
            }
            .tag(3)
            
            NavigationView {
                Settings()
            }
            .tabItem {
                VStack {
                    Image(systemName: "gear")
                    Text("Настройки")
                }
            }
            .tag(4)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(UserData())
            .environmentObject(SettingsStore())
            .environment(\.colorScheme, .dark)
    }
}

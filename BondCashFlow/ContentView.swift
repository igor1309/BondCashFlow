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
                PortfolioView()
            }
            .tabItem {
                VStack {
                    Image(systemName: "briefcase")
                    Text("Портфели")
                }
            }
            .tag(0)
            
            NavigationView {
                PositionListView()
            }
            .tabItem {
                VStack {
                    Image(systemName: "rectangle.3.offgrid")
                    Text("Позиции")
                }
            }
            .tag(1)
            
            NavigationView {
                CFCalendar()
            }
            .tabItem {
                VStack {
                    Image(systemName: "calendar")
                    Text("Календарь")
                }
            }
            .tag(2)
            
            NavigationView {
                DataBaseView()
            }
            .tabItem {
                VStack {
                    Image(systemName: "tray.2")
                    Text("База")
                }
            }
            .tag(3)
            
// MARK: Emissions как отдельный вью убран, сид как EmissionList в DataBaseView (бывший Settings)
//NavigationView {
//    Emissions()
//}
//.tabItem {
//    VStack {
//        Image(systemName: "tray.2.fill")
//        Text("Выпуски")
//    }
//}
//.tag(4)
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

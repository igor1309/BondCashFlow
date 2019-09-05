//
//  ShowAllFlowsPastAndFuture.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 04.09.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

//  MARK: TODO: redemption!!!!!!!
struct FlowRow3: View {
    var flow: CalendarCashFlow
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text(flow.date.toString())
                
                Spacer()
                
                Text(flow.amount.formattedGrouped) // (Double(qty) * flow).cuponSum.formattedGrouped
            }
            
            Group {
                HStack {
                    Text(flow.emitent)
                    
                    Spacer()
                    
                    Text(flow.instrument)
                }
                
                HStack {
                    Text(flow.portfolioName)
                        .foregroundColor(.systemOrange)
                    
                    Spacer()
                    
                    Text(flow.type.id)
                }
            }
            .font(.footnote)
            .foregroundColor(.secondary)
        }
    }
}


struct ShowAllFlowsPastAndFuture: View {
    @EnvironmentObject var userData: UserData
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        NavigationView {
            List {
                ForEach(userData.cashFlows
                    .sorted(by: {
                        ($0.date, $0.emitent, $0.instrument) < ($1.date, $1.emitent, $1.instrument)
                }), id: \.self) { flow in
                    
                    FlowRow3(flow: flow)
                        
                }
            }
            .navigationBarTitle("Все потоки")
                
            .navigationBarItems(trailing: TrailingButton(name: "Закрыть", closure: {
                self.presentation.wrappedValue.dismiss()
            }))
        }
    }
}

struct ShowAllFlowsPastAndFuture_Previews: PreviewProvider {
    static var previews: some View {
        ShowAllFlowsPastAndFuture()
            .environmentObject(UserData())
    }
}

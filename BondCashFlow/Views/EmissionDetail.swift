//
//  EmissionDetail.swift
//  BondsCashFlow
//
//  Created by Igor Malyarov on 27.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct EmissionDetail: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var userData: UserData
    
    var emission: EmissionStructure
    
    var flows: [CashFlowStructure] {
        userData.flows.filter({ $0.emissionID == emission.id }).sorted(by: { $0.couponNum < $1.couponNum })
    }
    
    //    var flows: [CashFlowStructure] {
    //        loadCashFlowListData().filter({ $0.emissionID == emission.id })
    //    }
    
    @State private var isFavorite: Bool// = false
        {
        didSet {
            userData.favoriteEmissions.updateValue(isFavorite, forKey: emission.id)
        }
    }
    
    var isFav: Bool
    init(emission: EmissionStructure, isFav: Bool) {
        self.emission = emission
        self.isFav = isFav
        self._isFavorite = State(initialValue: isFav)
    }
    
    var body: some View {
        
        NavigationView {
            VStack(alignment: .leading) {
                EmissionSubRow(emission: emission, bigStar: true)
                    .padding()
                    .onTapGesture {
                        self.isFavorite.toggle()
                        //  MARK: TODO haptic feedback
                }
                
                Button("КУПИТЬ") {
                    //  MARK: TODO добавить операцию покупки
                }
                .foregroundColor(.systemTeal)
                .padding(.horizontal)
                
                Text("Потоки")
                    .font(.title)
                    .fontWeight(.heavy)
                    .padding()
                //                    .border(Color.systemRed)
                
                List {
                    ForEach(flows, id: \.self) { flow in
                        FlowRow(flow: flow)
                    }
                }
            }
                
            .navigationBarTitle("Выпуск")
                
            .navigationBarItems(trailing: Button(action: {
                //  MARK: - add actions
                self.presentation.wrappedValue.dismiss()
            }) {
                Text("Закрыть")
                    .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 0))
            })
        }
    }
}

struct EmissionDetail_Previews: PreviewProvider {
    static var previews: some View {
        EmissionDetail(emission: EmissionStructure(),
                       isFav: true)
            .environmentObject(UserData())
    }
}

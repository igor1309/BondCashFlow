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
    
    var emission: Emission
    
    var flows: [Flow] {
        userData.flows
            .filter({ $0.emissionID == emission.id })
            .sorted(by: { $0.couponNum < $1.couponNum })
    }
    
    //    var flows: [Flow] {
    //        loadCashFlowListData().filter({ $0.emissionID == emission.id })
    //    }
    
    @State private var isFavorite: Bool// = false
        {
        didSet {
            userData.favoriteEmissions.updateValue(isFavorite, forKey: emission.id)
        }
    }
    
    var isFav: Bool
    init(emission: Emission, isFav: Bool) {
        self.emission = emission
        self.isFav = isFav
        self._isFavorite = State(initialValue: isFav)
    }
    
    @State var showModal = false
    
    var body: some View {
        
        NavigationView {
            VStack(alignment: .leading, spacing: 6) {
                //  MARK: TODO возможно в этом блоке нужно дать
                //  всю инфо по эмиссии что есть в базе
                //  и макет слегка иной нежели в строке списка
                EmissionSubRow(emission: emission, bigStar: true)
                    .padding(.horizontal)
                    .onTapGesture {
                        self.isFavorite.toggle()
                        let generator = UINotificationFeedbackGenerator()
                        generator.notificationOccurred(.success)
                }
                .padding(.top)
                
                Button("Купить этот выпуск") {
                    /// fav emission otherwise it would not show up in a list of emissions in AppPosition view
                    self.userData.favEmission(emissionID: self.emission.id)
                    
                    self.showModal = true
                }
                .padding(.horizontal)
                
                List {
                    ForEach(flows, id: \.self) { flow in
                        FlowRow(flow: flow)
                    }
                }
            }
                
            .sheet(isPresented: $showModal,
                   content: {
                    AddPosition(proposedEmissionID: self.emission.id)
                        .environmentObject(self.userData)
            })
                
                .navigationBarTitle("Выпуск и потоки")
                
                .navigationBarItems(trailing: TrailingButton(name: "Закрыть", closure: {
                    self.presentation.wrappedValue.dismiss()
                }))
        }
    }
}

struct EmissionDetail_Previews: PreviewProvider {
    static var previews: some View {
        EmissionDetail(emission: Emission(),
                       isFav: true)
            .environmentObject(UserData())
    }
}

//
//  GlobalPositionList.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 10.09.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct GlobalPositionList: View {
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 8) {
                ForEach(userData.positions
                    .map { $0.emissionID }
                    .removingDuplicates()
                    .sorted(), id: \.self) { emissionID in
                        
                        PositionForEmission(emissionID: emissionID)
                }
            }
        }
        .padding([.top, .leading, .trailing])
            
        .navigationBarTitle("По выпускам")
    }
}


struct GlobalPositionList_Previews: PreviewProvider {
    static var previews: some View {
        GlobalPositionList()
    }
}

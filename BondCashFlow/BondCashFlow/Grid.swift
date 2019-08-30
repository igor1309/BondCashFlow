//
//  Grid.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 22.07.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct Grid: View {
    @State var activeWeek = 0
    
    var body: some View {
        HStack {
//            VStack(alignment: .leading, spacing: 0) {
//                Text("l")
//                //                    .frame(height: 8)
//                Text("пн")
//                //                    .frame(height: 8)
//                Text("вт")
//                    .frame(height: 13)
//                Text("ср")
//                    .frame(height: 13)
//                Text("чт")
//                    .frame(height: 13)
//                Text("пт")
//                    .frame(height: 13)
//                Text("сб")
//                    .frame(height: 13)
//                Text("вс")
//                    .frame(height: 13)
//            }
//            .font(.caption)
//                .foregroundColor(.secondary)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 3) {
                    ForEach(0 ..< 25) { item in
                        GridColumn(activeWeek: self.$activeWeek, weekNo: item)
                    }
                }
            }
        }
//        .padding(.horizontal, 16)
    }
}

#if DEBUG
struct Grid_Previews: PreviewProvider {
    static var previews: some View {
        Grid()
    }
}
#endif

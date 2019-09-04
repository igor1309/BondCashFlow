//
//  GridItem.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 22.07.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct GridItem: View {
    @State var itemState: ItemState
    
    let w: CGFloat = 28
    let h: CGFloat = 12
    let cornerRadius: CGFloat = 2
    
    var body: some View {
        var fillColor: Color
        var borderColor: Color
        
        switch itemState {
        case .empty:
            fillColor = .clear
            borderColor = .systemGray
        case .full:
            fillColor = .systemOrange
            borderColor = .clear
        case .gray:
            fillColor = Color(hue: 0.0,
                              saturation: 0,
                              brightness: 0.7,
                              opacity: 1)
            borderColor = .clear
        case .none:
            fillColor = .clear
            borderColor = .clear
        }
        
        return Rectangle()
            .fill(fillColor)
            .cornerRadius(cornerRadius)
            .frame(width: w, height: h)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .border(borderColor)
    }
}

#if DEBUG
struct GridItem_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            GridItem(itemState: .empty)
            GridItem(itemState: .full)
            GridItem(itemState: .none)
        }
    }
}
#endif

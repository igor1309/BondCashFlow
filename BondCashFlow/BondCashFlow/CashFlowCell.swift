//
//  CashFlowCell.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 23.07.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct CashFlowCell2: View {
    @EnvironmentObject var userData: UserData
    
    var coupon: Int
    var face: Int
    
    var body: some View {
        
        HStack(spacing: 10) {
            
            Spacer().frame(width: 6).fixedSize()
            
            VStack(alignment: .leading) {
                if coupon > 0 {
                    HStack{
                        Text("Купон".uppercased())
                            .font(.caption)
                            .fontWeight(.light)
                        
                        Spacer()
                        
                        Text(coupon.formattedGrouped)
                            .font(.footnote)
                            .fontWeight(.light)
                            .foregroundColor(.systemOrange)
                    }
                }
                
                if face > 0 {
                    HStack{
                        Text("Номинал".uppercased())
                            .font(.caption)
                            .fontWeight(.light)
                        
                        Spacer()
                        
                        Text(face.formattedGrouped)
                            .font(.footnote)
                            .fontWeight(.light)
                            .foregroundColor(.systemOrange)
                    }
                }
            }
            .padding(.vertical, 4)
        }
        .padding(.bottom, 6)
    }
}

#if DEBUG
struct CashFlowCell_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            VStack {
                CashFlowCell2(coupon: 12345, face: 54321)
                CashFlowCell2(coupon: 12345, face: 54321)
                CashFlowCell2(coupon: 12345, face: 54321)
                CashFlowCell2(coupon: 12345, face: 54321)
            }
        }
        .environment(\.colorScheme, .dark)
        .previewLayout(.sizeThatFits)
        .environmentObject(UserData())
        .environment(\.sizeCategory, .extraLarge)
    }
}
#endif

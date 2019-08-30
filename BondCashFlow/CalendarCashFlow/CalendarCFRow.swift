//
//  CalendarCFRow.swift
//  TestCombine
//
//  Created by Igor Malyarov on 30.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct CalendarCFRow: View {
    var title: String
    var subtitle: String
    var detail: String
    var subdetail: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            HStack {
                Text(title)
                    .fontWeight(.light)
                
                Spacer()
                
                Text(detail)
                    .fontWeight(.light)
            }
            
            HStack {
                Text(subtitle)
                    .fontWeight(.light)
                
                Spacer()
                
                Text(subdetail)
                    .fontWeight(.light)
            }
            .foregroundColor(.systemOrange)
            .font(.footnote)
        }
        .padding(.bottom, 6)
        .opacity(0.8)
    }
}

struct CalendarCFRow_Previews: PreviewProvider {
    static var previews: some View {
        CalendarCFRow(title: "Ломбард Мастер",
                      subtitle: "БО-П02",
                      detail: 2_000_000.formattedGrouped,
                      subdetail: CalendarCashFlowType.principal.rawValue)
        .previewLayout(.sizeThatFits)
    }
}

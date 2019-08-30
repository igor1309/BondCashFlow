//
//  CalendarCashFlowRow.swift
//  TestCombine
//
//  Created by Igor Malyarov on 29.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct CalendarCashFlowRow: View {
    var documentRus: String
    var amount: Int
    var flowType: CalendarCashFlowType
    
    var body: some View {
        //  MARK: это плохо! должно быть в модели, а не в UI View!!
        //  MARK: TODO:
        let emitent = documentRus.split(separator: ",")[0]
        let emission = documentRus.dropFirst(2 + documentRus.split(separator: ",")[0].count)
        
        return CalendarCFRow(title: String(emitent),
                             subtitle: String(emission),
                             detail: amount.formattedGrouped,
                             subdetail: flowType.rawValue)
            
    }
}

struct CalendarCashFlowRow_Previews: PreviewProvider {
    static var previews: some View {
        CalendarCashFlowRow(documentRus: "Ломбард Мастер, БО-П02",
                            amount: 200_000_000,
                            flowType: .principal)
            .previewLayout(.sizeThatFits)
    }
}

//
//  PositionForEmission.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 10.09.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct PositionForEmission: View {
    @EnvironmentObject var userData: UserData
    var emissionID: EmissionID
    
    var body: some View {
        
        let emission = userData.emissions.first(where: { $0.id == emissionID })
        
        let positionsForEmissionID = userData.positions.filter { $0.emissionID == self.emissionID }
        
        let portfolioIDsForEmissionIDs = positionsForEmissionID.map { $0.portfolioID }.removingDuplicates()
        
        let portfolioNamesForEmissionID = userData.portfolios
            .filter { portfolioIDsForEmissionIDs.contains($0.id) }
            .map { $0.name }
        
        let nearestFlowDate = userData.workingFlows
            .filter { $0.date >= Date() && $0.emissionID == emissionID }
            .map { $0.date }.min()
        
        let qty = positionsForEmissionID.reduce(0, { $0 + $1.qty })
        
        return Row(title: emission?.documentRus ?? "#н/д",
                   detail: qty.formattedGrouped,
                   detailExtra: "кол-во",
                   title2: stringFromArray(portfolioNamesForEmissionID),
                   detail2: (Int(emission?.nominalPrice ?? 0) * qty).formattedGrouped,
                   subtitle: "<TBD: nearest flow>",
                   subdetail: emission?.maturityDate.toString() ?? "#н/д",
                   extraline: nearestFlowDate?.toString() ?? "#н/д")
    }
}

struct PositionForEmission_Previews: PreviewProvider {
    static var previews: some View {
        PositionForEmission(emissionID: 62935)
    }
}

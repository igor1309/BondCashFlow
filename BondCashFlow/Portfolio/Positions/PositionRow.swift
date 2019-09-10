//
//  PositionRow.swift
//  BondsCashFlow
//
//  Created by Igor Malyarov on 27.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct PositionRow: View {
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var settings: SettingsStore
    
    @Binding var position: Position
    
    var emission: Emission? {
        userData.emissions.first(where: { $0.id == position.emissionID })
    }
    
    var portfolio: Portfolio? {
        userData.portfolios.first(where: { $0.id == position.portfolioID })
    }
    
    @State private var showDetail = false
    @State private var showConfirmation = false
    
    private func deletePosition(position: Position) {
        if let index = userData.positions.firstIndex(where: { $0.id == position.id}) {
            userData.positions.remove(at: index)
            
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
        }
    }
    
    private func doubleQty() {
        if let index = userData.positions.firstIndex(where: { $0.id == position.id}) {
            userData.positions[index].qty = 2 * position.qty
        }
    }
    private func halfQty() {
        if position.qty > 1{
            if let index = userData.positions.firstIndex(where: { $0.id == position.id}) {
                userData.positions[index].qty = Int((Double(position.qty) / 2).rounded(.up))
            }
        }
    }
    
    
    var body: some View {
        
        let portfolioName: String = portfolio?.name ?? "#н/д"
        
        let isin = emission?.isinCode == nil ? "" : " ISIN: " + String(emission?.isinCode ?? "")
        
        let documentRus = emission?.documentRus ?? ""
        
        let faceValue = position.qty * Int(emission?.nominalPrice ?? 0)
        
        let maturityDate = emission?.maturityDate.toString() ?? "#н/д"
        
        let futureFlowsForEmission = userData.flows
            .filter { $0.date >= Date() && $0.emissionID == emission?.id }
        
        let nearestFlowDate = futureFlowsForEmission.map { $0.date }.min()
        
        let flowsForNearestDate = futureFlowsForEmission.filter { $0.date == nearestFlowDate }
        
        let couponForNearestDate = flowsForNearestDate.reduce(0, { $0 + $1.cuponSum })
        
        let faceForNearestDate = flowsForNearestDate.reduce(0, { $0 + $1.redemtion })
        
        let nearestFlow = position.qty * Int(couponForNearestDate + faceForNearestDate)
        
        return VStack {
            
            Row(topline: portfolioName.uppercased(),
                title: documentRus,
                detail: position.qty.formattedGrouped,
                detailExtra: "кол-во",
                
                title2: "#" + String(position.emissionID) + isin,
                detail2: faceValue.formattedGrouped,
                detailExtra2: "номинал",
                
                subtitle: nearestFlow == 0 ? "#н/д" : "Ближайший поток\n" + nearestFlow.formattedGrouped,
                subdetail: maturityDate,
                extraline: nearestFlowDate?.toString() ?? "#н/д")
                
                .onTapGesture { self.showDetail = true }
                
                .contextMenu {
                    Button(action: {
                        self.showConfirmation = true
                    }) {
                        HStack {
                            Image(systemName: "trash")
                            Spacer()
                            Text("Закрыть позицию")
                        }
                    }
                    Button(action: {
                        self.doubleQty()
                    }) {
                        HStack {
                            Image(systemName: "2.circle")
                            Spacer()
                            Text("Удвоить позицию")
                        }
                    }
                    Button(action: {
                        self.halfQty()
                    }) {
                        HStack {
                            Image(systemName: "square.and.line.vertical.and.square.fill")
                            Spacer()
                            Text("Уполовинить позицию")
                        }
                    }
            }
                
            .actionSheet(isPresented: self.$showConfirmation) {
                ActionSheet(title: Text("Закрыть?"),
                            message: Text("Отменить закрытие позиции будет невозможно."),
                            buttons: [
                                .cancel(Text("Отмена")),
                                .destructive(Text("Да, закрыть позицию"),
                                             action: {
                                                self.deletePosition(position: self.position)
                                })
                ])
            }
                
            .sheet(isPresented: $showDetail,
                   content: {
                    PositionDetail(position: self.$position, emission: self.emission)
                        .environmentObject(self.userData)
                        .environmentObject(self.settings)
            })
        }
    }
}

struct PositionRow_Previews: PreviewProvider {
    static var previews: some View {
        List {
            PositionRow(position:
                .constant(Position(portfolioID: UUID(uuidString: "9009E038-AF68-4E55-A15E-F6C5059B79BD") ?? UUID(),
                                   emissionID: 460,
                                   qty: 5555)))
            PositionRow(position:
                .constant(Position(portfolioID: UUID(uuidString: "9009E038-AF68-4E55-A15E-F6C5059B79BD") ?? UUID(),
                                   emissionID: 460,
                                   qty: 5555)))
            PositionRow(position:
                .constant(Position(portfolioID: UUID(uuidString: "9009E038-AF68-4E55-A15E-F6C5059B79BD") ?? UUID(),
                                   emissionID: 460,
                                   qty: 5555)))
            PositionRow(position:
                .constant(Position(portfolioID: UUID(uuidString: "9009E038-AF68-4E55-A15E-F6C5059B79BD") ?? UUID(),
                                   emissionID: 460,
                                   qty: 5555)))
            PositionRow(position:
                .constant(Position(portfolioID: UUID(uuidString: "9009E038-AF68-4E55-A15E-F6C5059B79BD") ?? UUID(),
                                   emissionID: 460,
                                   qty: 5555)))
        }
        .environmentObject(UserData())
        .environmentObject(SettingsStore())
        .previewLayout(.sizeThatFits)
        .environment(\.colorScheme, .dark)
    }
}

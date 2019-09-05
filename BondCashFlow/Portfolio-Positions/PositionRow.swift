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
    
    var position: Position
    
    var emission: Emission? {
        userData.emissions.first(where: { $0.id == position.emissionID })
    }
    
    @State private var showDetail = false
    @State private var showConfirmation = false
    
    private func deletePosition(position: Position) {
        if let index = userData.positions.firstIndex(where: { $0.id == position.id}) {
            userData.positions.remove(at: index)
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
        
        let isin = emission?.isinCode == nil ? "" : " ISIN: " + String(emission?.isinCode ?? "")
        
        let documentRus = emission?.documentRus ?? ""
        
        let maturityDate = emission?.maturityDate.toString() ?? ""
        
        return VStack(alignment: .leading, spacing: 4) {
            
            HStack(alignment: .firstTextBaseline) {
                Text(documentRus)
                
                Spacer()
                
                Text(position.qty.formattedGrouped)
                    .foregroundColor(.systemOrange)
            }
            
            HStack {
                Text("id: " + String(position.emissionID))
                    .fontWeight(.light)
                
                Spacer()
                
                Text(isin)
                    .fontWeight(.light)
                
                Spacer()
                
                Text(maturityDate)
            }
            .font(.footnote)
            .foregroundColor(.secondary)
            
            Text(position.portfolioName)
                .font(.caption)
                .fontWeight(.light)
                .foregroundColor(.systemOrange)
        }
        .onTapGesture {
            self.showDetail = true
        }
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
                    Text("Удвоить")
                }
            }
            Button(action: {
                self.halfQty()
            }) {
                HStack {
                    Image(systemName: "square.and.line.vertical.and.square.fill")
                    Spacer()
                    Text("Уполовинить")
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
                PositionDetail(position: self.position, emission: self.emission)
                    .environmentObject(self.userData)
        })
        
    }
}

struct PositionRow_Previews: PreviewProvider {
    static var previews: some View {
        List {
            PositionRow(position: Position(portfolioName: "Optimus Prime",
                                           emissionID: 460,
                                           qty: 5555))
            PositionRow(position: Position(portfolioName: "Optimus Prime",
                                           emissionID: 2928,
                                           qty: 5555))
            PositionRow(position: Position(portfolioName: "Optimus Prime",
                                           emissionID: 5165,
                                           qty: 5555))
            PositionRow(position: Position(portfolioName: "Optimus Prime",
                                           emissionID: 2717,
                                           qty: 5555))
        }
        .environmentObject(UserData())
        .previewLayout(.sizeThatFits)
    }
}

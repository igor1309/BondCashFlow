//
//  UserData.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 22.07.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//
//  A model object that stores app data.


import Foundation

final class UserData: ObservableObject {
    private let defaults = UserDefaults.standard
    
    @Published var portfolios: [Portfolio] = portfolioData {
        didSet {
            saveJSON(data: portfolios, filename: "portfolios.json")
        }
    }
    
    @Published var positions: [Position] = positionData {
        didSet {
            saveJSON(data: positions, filename: "positions.json")
        }
    }
    
    @Published var baseDate = Date().firstDayOfWeekRU.startOfDay // DateComponents(calendar: .current, year: 2019, month: 11, day: 25).date!//Date()//DateComponents(calendar: .current, year: 2011, month: 08, day: 11).date!
    
    @Published var emissionMetadata: CBondEmissionMetadata? = emissionMetadataData {
        didSet {
            saveJSON(data: emissionMetadata, filename: "emissionMetadata.json")
        }
    }
    
    @Published var flowMetadata: CBondFlowMetadata? = flowMetadataData {
        didSet {
            saveJSON(data: flowMetadata, filename: "flowMetadata.json")
        }
    }
    
    @Published var emissions = emissionData {
        didSet {
            saveJSON(data: emissions, filename: "emissions.json")
        }
    }
    
    @Published var flows = cashFlowData {
        didSet {
            saveJSON(data: flows, filename: "flows.json")
        }
    }
    
    @Published var favoriteEmissions: [EmissionID: Bool] = favoriteEmissionsData {
        didSet {
            saveJSON(data: favoriteEmissions, filename: "favoriteEmissions.json")
        }
    }
}

extension UserData {
    /// выреска из потоков - только те, по которым есть позиции
    var workingFlows: [Flow] {
        flows.filter { flow in
            positions.map { $0.emissionID }.removingDuplicates().contains(flow.emissionID)
        }
    }
    
    var cashFlows: [CalendarCashFlow] { calculateCashFlows().filter { $0.date >= baseDate } .sorted { $0.date < $1.date } }
    
    var hasAtLeastTwoPortfolios: Bool {
        positions.map({ $0.portfolioID }).removingDuplicates().count > 1
    }
    
    var emitents: [String] {
        emissions.map { $0.emitentNameRus }.removingDuplicates()
    }
    
    var portfolioNames: [String] { portfolios.map { $0.name } }
}


extension UserData {
    func calculateCashFlows() -> [CalendarCashFlow] {
        
        print("\n\(flows.count) - total # of flows in database")
        /// get a slice of `emissions` for those in `positions` only
        let flowsForEmissionsInPortfolio = flows.filter {
            positions.map({ $0.emissionID }).contains($0.emissionID)
        }
        
        print("\(flowsForEmissionsInPortfolio.count) - flows of interest (flowsForEmissionsInPortfolio)")
        
        /// `testing`if there any records with coupon ad redemption simultaneously
        let flowsWithCouponAndRedemption = flows.filter {
            $0.cuponSum > 0 && $0.redemtion > 0
        }
        print("\(flowsWithCouponAndRedemption.count) - flowsWithCouponAndRedemption")
        
        var cashFlows: [CalendarCashFlow] = []
        
        ///  loop through `all positions` `and selected flows` (with emissions in positions) to create a cashFlows array
        for position in positions {
            for flow in flowsForEmissionsInPortfolio {
                
                ///  match by `emissionID` field
                if position.emissionID == flow.emissionID {
                    
                    ///  get `emitent` from emissions and create `instrument` from emission name (documentRus) (get rid of emitent name in documentRus)
                    let emission = emissions.first { $0.id == position.emissionID }
                    let emitent = emission?.emitentNameRus ?? "#n/a"
                    let doc = emission?.documentRus
                    let instrument = String(doc?.dropFirst(2 + (doc?.split(separator: ",")[0].count ?? 0)) ?? "#n/a")
                    
                    /// append  non-zero `coupon ` flow
                    if flow.cuponSum > 0 {
                        let cashFlowCoupon = CalendarCashFlow(date: flow.date, portfolioID: position.id, emitent: emitent, instrument: instrument, amount: Int(Double(position.qty) * flow.cuponSum), type: .coupon)
                        cashFlows.append(cashFlowCoupon)
                    }
                    
                    /// append non-zero `face` (principal) flow
                    if flow.redemtion > 0 {
                        let cashFlowPrincipal = CalendarCashFlow(date: flow.date, portfolioID: position.id, emitent: emitent, instrument: instrument, amount: Int(Double(position.qty) * flow.redemtion), type: .face)
                        cashFlows.append(cashFlowPrincipal)
                    }
                }
            }
        }
        //        print(cashFlows)
        if cashFlows.count > 0 {
            print(cashFlows[0])
        }
        print("… and more: TOTAL \(cashFlows.count) - cashFlows.count")
        
        return cashFlows
    }
}

extension UserData {
    func loadTestPositions() -> Bool{
        let testPortfolios = [
            Portfolio(name: "Optimus Prime", broker: "Winterfell Direct", comment: "Winter is coming…"),
            Portfolio(name: "Bumblebee", broker: "Daenerys IB", comment: "the First of Her Name, the Unburnt…"),
            Portfolio(name: "Megatron", broker: "Casterly Rock", comment: "A Lannister always pays his debts.")
        ]
        
        let emissionIDsWithFlowsFromToday = flows.filter({ $0.date >= Date() }).map({ $0.emissionID })
        let count = emissionIDsWithFlowsFromToday.count
        
        if emissionIDsWithFlowsFromToday.isEmpty {
            return false
        } else {
            var testPositions: [Position] = []
            
            for testPortfolio in testPortfolios {
                for _ in 1...Int.random(in: 2 ..< 8) {
                    let position = Position(portfolioID: testPortfolio.id,
                                            emissionID: emissionIDsWithFlowsFromToday[Int.random(in: 0 ..< count)],
                                            qty: Int.random(in: 1 ..< 1001))
                    testPositions.append(position)
                }
            }
            
            if positions.count > 0 {
                backupPositions()
            }
            
            portfolios = testPortfolios
            positions = testPositions
            return true
        }
    }
    
    func backupPositions() {
        saveJSON(data: positions, filename: "positions_backup.json")
    }
    
    func restorePositionsFromBackup() -> Bool {
        guard let backupPositions: [Position] = loadFromDocDir("positions_backup.json") else {
            return false
        }
        positions = backupPositions
        return true
    }
}

extension UserData {
    func deletePortfolio(_ portfolio: Portfolio) {
        /// delete all positions for portfolio
        positions.removeAll(where: { $0.portfolioID == portfolio.id })
        
        /// delete portfolio
        if let index = portfolios.firstIndex(where: { $0.id == portfolio.id }) {
            portfolios.remove(at: index)
        }
    }
}

extension UserData {
    /// номинальная стоимость портфеля
    func faceValueForPortfolio(_ portfolio: Portfolio) -> Int {
        let positionsForPortfolio = positions.filter { $0.portfolioID == portfolio.id }
        
        var faceValue = 0
        
        for position in positionsForPortfolio {
            let emission = emissions.first(where: { $0.id == position.emissionID })
            
            faceValue += position.qty * Int(emission?.nominalPrice ?? 0)
        }
        
        return faceValue
    }
    
    /// названия выпусков для позиций  в портфеле
    func getEmissionNamesForPortfilo(_ portfolio: Portfolio) -> [String] {
        let positionsForPortfolio = positions.filter { $0.portfolioID == portfolio.id }
        
        return positionsForPortfolio
            .map { position in
                (self.emissions.first(where: { $0.id == position.emissionID })?.documentRus ?? "") }
    }
    
    /// потоки по позиция в портфеле
    func getFlowsForPortfolio(_ portfolio: Portfolio) -> [Flow] {
        let positionsForPortfolio = positions.filter { $0.portfolioID == portfolio.id }
        
        let emissionsForPortfolio = positionsForPortfolio.map { $0.emissionID }
        
        return flows.filter { emissionsForPortfolio.contains($0.emissionID) }
    }
    
    /// будущие потоки по позициям в портфеле
    func getFutureFlowsForPortfolio(_ portfolio: Portfolio) -> [Flow] {
        let positionsForPortfolio = positions.filter { $0.portfolioID == portfolio.id }
        
        let emissionsForPortfolio = positionsForPortfolio.map { $0.emissionID }
        
        return flows.filter { emissionsForPortfolio.contains($0.emissionID) && $0.date >= Date()}
    }
    
    /// дата ближайшего потока для портфеля
    func nearestFlowDateForPortfolio(_ portfolio: Portfolio) -> Date  {
        getFutureFlowsForPortfolio(portfolio).map { $0.date }.min() ?? .distantPast
    }
    
    /// размер ближайшего потока для портфеля
    func nearestFlowForPortfolio(_ portfolio: Portfolio) -> Int {
        /// позиции по этому портфелю
        let positionsForPortfolio = positions.filter { $0.portfolioID == portfolio.id }
        
        /// дата блихайших потоков для выпусков в портфеле
        let nearestFlowDate = nearestFlowDateForPortfolio(portfolio)
        
        /// потоки для эмиссий в этом портфеле с самой близкой датой
        let nearestFlowsForPortfolio = flows.filter { $0.date == nearestFlowDate }
        
        /// значение потока = сумма по всем отобранным позициям и потокам = (купон + номинал) * количество в позиции
        let flowAmount = nearestFlowsForPortfolio.reduce(0, { sum, flow in
            sum + Int(flow.cuponSum + flow.redemtion) *
                (positionsForPortfolio.first(where: { position in
                    position.emissionID == flow.emissionID })?.qty ?? 0) })
        
        return flowAmount
    }
}

extension UserData {
    func deletePortfolio(portfolio: Portfolio) {
        guard let index = portfolios.firstIndex(of: portfolio) else {
            return
        }
        portfolios.remove(at: index)
        
        for idx in positions.indices {
            if positions[idx].portfolioID == portfolio.id {
                positions.remove(at: idx)
            }
        }
    }
    
    func favEmission(emissionID: EmissionID) {
        favoriteEmissions.updateValue(true, forKey: emissionID)
    }
    //  MARK: TODO fix func
    //        func unfavEmission(emissionID: EmissionID) {
    //            favoriteEmissions.removeValue(forKey: EmissionID)
    //        }
    
    func reset() {
        emissionMetadata = nil
        flowMetadata = nil
        emissions = []
        flows = []
        favoriteEmissions = [:]
        portfolios = []
        positions = []
        //        cashFlows = []
        baseDate = Date().firstDayOfWeekRU.startOfDay
    }
}

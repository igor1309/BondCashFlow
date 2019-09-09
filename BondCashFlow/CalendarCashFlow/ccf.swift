//
//  ccf.swift
//  TestCombine
//
//  Created by Igor Malyarov on 30.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import Foundation

let ccf2 = [
    CalendarCashFlow(date: Date().addWeeks(0).firstDayOfWeekRU.addDays(0), portfolioID: UUID(uuidString: "9009E038-AF68-4E55-A15E-F6C5059B79BD") ?? UUID(), emitent: "Мастер", instrument: "Fhhsd-83456", amount: 100000, type: .coupon),
    CalendarCashFlow(date: Date().addWeeks(0).firstDayOfWeekRU.addDays(2), portfolioID: UUID(uuidString: "9009E038-AF68-4E55-A15E-F6C5059B79BD") ?? UUID(), emitent: "Ломбард", instrument: "Fhhsd-83456", amount: 10000, type: .face),
    CalendarCashFlow(date: Date().addWeeks(1).firstDayOfWeekRU.addDays(3), portfolioID: UUID(uuidString: "9009E038-AF68-4E55-A15E-F6C5059B79BD") ?? UUID(), emitent: "Ломбард", instrument: "Fhhsd-83456", amount: 200000, type: .coupon),
    CalendarCashFlow(date: Date().addWeeks(2).firstDayOfWeekRU.addDays(2), portfolioID: UUID(uuidString: "9009E038-AF68-4E55-A15E-F6C5059B79BD") ?? UUID(), emitent: "Мастер", instrument: "Fhhsd-83456", amount: 200000, type: .face),
    CalendarCashFlow(date: Date().addWeeks(2).firstDayOfWeekRU.addDays(3), portfolioID: UUID(uuidString: "9009E038-AF68-4E55-A15E-F6C5059B79BD") ?? UUID(), emitent: "Мастер", instrument: "Fhhsd-83456", amount: 100000, type: .coupon),
    CalendarCashFlow(date: Date().addWeeks(3).firstDayOfWeekRU.addDays(1), portfolioID: UUID(uuidString: "9009E038-AF68-4E55-A15E-F6C5059B79BD") ?? UUID(), emitent: "Ломбард", instrument: "Fhhsd-83456", amount: 10000, type: .face),
    CalendarCashFlow(date: Date().addWeeks(5).firstDayOfWeekRU.addDays(3), portfolioID: UUID(uuidString: "9009E038-AF68-4E55-A15E-F6C5059B79BD") ?? UUID(), emitent: "Ломбард", instrument: "Fhhsd-83456", amount: 200000, type: .coupon),
    CalendarCashFlow(date: Date().addWeeks(8).firstDayOfWeekRU.addDays(3), portfolioID: UUID(uuidString: "9009E038-AF68-4E55-A15E-F6C5059B79BD") ?? UUID(), emitent: "Ломбард", instrument: "Fhhsd-83456", amount: 200000, type: .face),
    CalendarCashFlow(date: Date().addWeeks(15).firstDayOfWeekRU.addDays(4), portfolioID: UUID(uuidString: "9009E038-AF68-4E55-A15E-F6C5059B79BD") ?? UUID(), emitent: "Мастер", instrument: "Fhhsd-83456", amount: 200000, type: .coupon),
    CalendarCashFlow(date: Date().addWeeks(19).firstDayOfWeekRU.addDays(0), portfolioID: UUID(uuidString: "9009E038-AF68-4E55-A15E-F6C5059B79BD") ?? UUID(), emitent: "Мастер", instrument: "Fhhsd-83456", amount: 200000, type: .coupon),
    CalendarCashFlow(date: Date().addWeeks(26).firstDayOfWeekRU.addDays(1), portfolioID: UUID(uuidString: "9009E038-AF68-4E55-A15E-F6C5059B79BD") ?? UUID(), emitent: "Ломбард", instrument: "Fhhsd-83456", amount: 200000, type: .coupon)
]

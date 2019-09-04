//
//  ccf.swift
//  TestCombine
//
//  Created by Igor Malyarov on 30.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import Foundation

let ccf = CalCashFlow(date: Date().addWeeks(5),
    flows: [
    CalCashFlowItem(portfolioName: "Bumblebee", documentRus: "Ломбард Мастер, БО-П02", amount: 20_000_000, flowType: .principal),
    CalCashFlowItem(portfolioName: "Bumblebee", documentRus: "Ломбард Мастер, БО-П02", amount: 200_000, flowType: .coupon),
    CalCashFlowItem(portfolioName: "Bumblebee", documentRus: "Достоевский, БО-П02", amount: 200_000, flowType: .coupon),
    CalCashFlowItem(portfolioName: "Bumblebee", documentRus: "Центр-Торг, БО-П02", amount: 3_000_000, flowType: .principal),
    CalCashFlowItem(portfolioName: "Bumblebee", documentRus: "Центр-Торг, БО-П02", amount: 2_000_000, flowType: .principal),
    CalCashFlowItem(portfolioName: "Optimus Prime", documentRus: "Центр-Торг, БО-П02", amount: 100_000, flowType: .coupon),
    CalCashFlowItem(portfolioName: "Optimus Prime", documentRus: "Палата А, БО-П02", amount: 2_000_000, flowType: .principal),
    CalCashFlowItem(portfolioName: "Optimus Prime", documentRus: "Палата А, БО-П02", amount: 100_000, flowType: .coupon),
    CalCashFlowItem(portfolioName: "Megatron", documentRus: "Достоевский, БО-П02", amount: 200_000, flowType: .coupon),
    CalCashFlowItem(portfolioName: "Megatron", documentRus: "Башни кремля, ПУТ-2676", amount: 2_000_000, flowType: .principal),
    CalCashFlowItem(portfolioName: "Megatron", documentRus: "Башни кремля, ПУТ-2676", amount: 20_000, flowType: .coupon),
    CalCashFlowItem(portfolioName: "Megatron", documentRus: "Маджонг, БО-П02", amount: 50_000, flowType: .coupon),
    CalCashFlowItem(portfolioName: "Megatron", documentRus: "Маджонг, БО-П02", amount: 2_000_000, flowType: .principal)
])

let ccf2 = [
    CalendarCashFlow(date: Date().firstDayOfWeekRU.addDays(0), portfolioName: "Megatron", emitent: "Мастер", instrument: "Fhhsd-83456", amount: 100000, type: .coupon),
    CalendarCashFlow(date: Date().firstDayOfWeekRU.addDays(2), portfolioName: "Megatron", emitent: "Ломбард", instrument: "Fhhsd-83456", amount: 10000, type: .face),
    CalendarCashFlow(date: Date().addWeeks(1).firstDayOfWeekRU.addDays(3), portfolioName: "Bumblebee", emitent: "Ломбард", instrument: "Fhhsd-83456", amount: 200000, type: .coupon),
    CalendarCashFlow(date: Date().addWeeks(2).firstDayOfWeekRU.addDays(2), portfolioName: "Bumblebee", emitent: "Мастер", instrument: "Fhhsd-83456", amount: 200000, type: .face),
    CalendarCashFlow(date: Date().addWeeks(2).firstDayOfWeekRU.addDays(3), portfolioName: "Bumblebee", emitent: "Мастер", instrument: "Fhhsd-83456", amount: 100000, type: .coupon),
    CalendarCashFlow(date: Date().addWeeks(3).firstDayOfWeekRU.addDays(1), portfolioName: "Bumblebee", emitent: "Ломбард", instrument: "Fhhsd-83456", amount: 10000, type: .face),
    CalendarCashFlow(date: Date().addWeeks(5).firstDayOfWeekRU.addDays(3), portfolioName: "Bumblebee", emitent: "Ломбард", instrument: "Fhhsd-83456", amount: 200000, type: .coupon),
    CalendarCashFlow(date: Date().addWeeks(8).firstDayOfWeekRU.addDays(3), portfolioName: "Megatron", emitent: "Ломбард", instrument: "Fhhsd-83456", amount: 200000, type: .face),
    CalendarCashFlow(date: Date().addWeeks(15).firstDayOfWeekRU.addDays(4), portfolioName: "Megatron", emitent: "Мастер", instrument: "Fhhsd-83456", amount: 200000, type: .coupon),
    CalendarCashFlow(date: Date().addWeeks(19).firstDayOfWeekRU.addDays(0), portfolioName: "Megatron", emitent: "Мастер", instrument: "Fhhsd-83456", amount: 200000, type: .coupon),
    CalendarCashFlow(date: Date().addWeeks(26).firstDayOfWeekRU.addDays(1), portfolioName: "Megatron", emitent: "Ломбард", instrument: "Fhhsd-83456", amount: 200000, type: .coupon)
]

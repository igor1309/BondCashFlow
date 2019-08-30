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

//
//  ExchangeModel.swift
//  RateToday
//
//  Created by Alexader Malygin on 06.12.2019.
//  Copyright © 2019 Alexader Malygin. All rights reserved.
//

import Foundation

struct Initial: Codable {
    let date: String
    let bank: String
    let baseCurrency: Int
    let baseCurrencyLit: String
    let exchangeRate: [Exchange]
}

struct Exchange: Codable {
    let baseCurrency: String?
    let currency: String?
    let saleRate: Double?
    let purchaseRate: Double?
}

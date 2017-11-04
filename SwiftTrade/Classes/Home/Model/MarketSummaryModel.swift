//
//  MarketSummaryModel.swift
//  SwiftTrade
//
//  Created by yaoliangjun on 2017/10/24.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//

import UIKit

class MarketSummaryModel: NSObject {
    
    var amount: String?                 // 成交额
    var buyPrice: String?
    var change: String?                 // 涨跌额
    var changeRate: String?             // 涨跌率
    var coinIcon: String?
    var coinName: String?            // 莱特币
    var coinSymbol: String?          // ltc
    var highPrice: String?
    var lastDayAvgPrice: String?
    var lastDayPrice: String?
    var lastPrice: String?             // 最后成交价
    var lowPrice: String?
    var name: String?               // ltc_cny
    var quotaDuration: String?
    var sellPrice: String?
    var volume: String?                // 成交量
}

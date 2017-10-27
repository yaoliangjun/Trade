//
//  MarketSummaryModel.swift
//  SwiftTrade
//
//  Created by yaoliangjun on 2017/10/24.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//

import UIKit

class MarketSummaryModel: NSObject {
    
    var amount : Int?                 // 成交额
    var buyPrice : Float?
    var change : Int?                 // 涨跌额
    var changeRate : Int?             // 涨跌率
    var coinIcon : String?
    var coinName : String?            // 莱特币
    var coinSymbol : String?          // ltc
    var highPrice : Int?
    var lastDayAvgPrice : Int?
    var lastDayPrice : Int?
    var lastPrice : Int?             // 最后成交价
    var lowPrice : Int?
    var name : String?               // ltc_cny
    var quotaDuration : AnyObject?
    var sellPrice : Float?
    var volume : Int?                // 成交量
}

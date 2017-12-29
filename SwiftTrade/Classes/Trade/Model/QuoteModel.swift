//
//  QuoteModel.swift
//  SwiftTrade
//
//  Created by yaoliangjun on 2017/12/29.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//

import UIKit

class QuoteModel: NSObject {

    var buyProportion: String?  // 买单委托量占比, 比如0.59, 需要显示成59%
    var sellProportion: String? // 卖单委托量占比
    var buyQuoteList: [QuoteDetailModel]?
    var sellQuoteList: [QuoteDetailModel]?
    var status: String?         // 涨跌情况 ['UP', 'DOWN', 'SAME']
    var lastPrice: String?      // 最新成交价格

    // 模型映射
    override static func mj_objectClassInArray() -> [AnyHashable : Any]! {
        return ["buyQuoteList": QuoteDetailModel.self, "sellQuoteList": QuoteDetailModel.self]
    }
}

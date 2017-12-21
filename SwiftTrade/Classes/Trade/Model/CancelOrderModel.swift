//
//  CancelOrderModel.swift
//  SwiftTrade
//
//  Created by yaoliangjun on 2017/12/8.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//  撤单模型

import UIKit

class CancelOrderModel: NSObject {

//    {
//    "market" : "ltc_ntc",
//    "coinName" : "莱特币",
//    "coinIcon" : "http:\/\/47.92.150.205:9070\/feedback\/coins\/LTC.png",
//    "id" : 33290,
//    "price" : 35,
//    "volume" : 2,
//    "dealVolume" : 0,
//    "dealPrice" : null,
//    "status" : "OPEN",
//    "createdAt" : 1513823819000,
//    "type" : "BUY"
//    }

    var market: String?
    var coinName: String?
    var coinIcon: String?
    var id: String?
    var price: String?
    var volume: String?
    var dealVolume: String?
    var dealPrice: String?
    var status: String?
    var createdAt: String?
    var type: String?
}

//
//  AppConstants.swift
//  SwiftTrade
//
//  Created by yaoliangjun on 2017/10/13.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//  App常量

import UIKit

class AppConstants: NSObject {

    // 颜色常量值
    static let navigationBarColor = UIColor(hexValue: 0x222126) // 导航栏背景颜色 kTabBarColor
    static let tabBarColor = navigationBarColor // TabBar背景颜色
    static let separateLineColor = UIColor(hexValue: 0xCCCCCC) // 分割线颜色
    static let goldColor = UIColor(hexValue: 0xFDE593) // 金色
    static let greyTextColor = UIColor(hexValue: 0x333333) // 灰色文字颜色
    static let gapColor = UIColor(hexValue: 0xEDEDED) // 灰色空隙颜色
    static let grayColor = UIColor(hexValue: 0xCCCCCC) // 灰色
    static let redTextColor = UIColor(hexValue: 0xFE3131) // 红色文字
    static let blueTextColor = UIColor(hexValue: 0x00A0E9) // 蓝色文字
    
    // 字符串常量
    static let token = "token"
    static let account = "account"
    static let startGetVerifyCode = "startGetVerifyCode"
    static let isFirstLaunching = "isFirstLaunching"

    // 限价、市价
    public enum PriceType {
        case limited
        case market
    }

    // 仓位
    public enum Postion: Int {
        case full = 100
        case oneHalf
        case oneThird
        case oneFourth
    }
}

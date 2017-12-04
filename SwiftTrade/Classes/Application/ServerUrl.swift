//
//  ServerUrl.swift
//  SwiftTrade
//
//  Created by yaoliangjun on 2017/10/17.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//

import UIKit

class ServerUrl: NSObject {
    
    // 服务器地址
    static let baseUrl = "http://47.92.150.205:9000"
    
    /******************************************  注册登录  ************************************************/
    
    static let login = "/user/login" // 登录
    static let register = "/user/register" // 注册
    static let verifyCode = "/user/veri-code" // 获取短信验证码
    
    /******************************************  主页  ***************************************************/

    static let marketSummary = "/market/summary" // 获取当前各币种行情

    /******************************************  资讯  ***************************************************/

    static let infoList = "/info/list" // 获取资讯

    /******************************************  账户  ***************************************************/

    static let myAssets = "/finance/coin/myAssets" //我的资产
}

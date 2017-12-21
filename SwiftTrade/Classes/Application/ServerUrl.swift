//
//  ServerUrl.swift
//  SwiftTrade
//
//  Created by yaoliangjun on 2017/10/17.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//

import UIKit

class ServerUrl: NSObject {

    enum Environment {
        case develop
        case production
    }

    /** 服务器环境 */
    static let environment = Environment.production

    static func baseUrl() -> String {
        if environment == .develop {
            return "http://47.92.150.205:9000"

        } else {
            return "http://47.52.142.113:9070"
        }
    }
    

    /** 注册登录 */
    static let login = "/user/login" // 登录
    static let register = "/user/register" // 注册
    static let verifyCode = "/user/veri-code" // 获取短信验证码
    static let findPassword = "/user/forget-pwd" // 忘记登陆密码
    static let nationals = "/finance/qianbao/nationals" // 获取国家地区区号


    /** 首页 */
    static let marketSummary = "/market/summary" // 获取当前各币种行情


    /** 交易 */
    static let cancelOrders = "/trade" // 撤单列表


    /** 资讯 */
    static let infoList = "/info/list" // 获取资讯


    /** 账户 */
    static let myAssets = "/finance/coin/myAssets" //我的资产
}

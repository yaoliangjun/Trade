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
    static let baseUrl = "http://api.qiyelian.cc:9000"
    
    
    // 注册登录
    static let loginUrl = "/user/login" // 登录
    
    
    // 主页
    static let marketSummary = "/market/summary" // 获取当前各币种行情
}

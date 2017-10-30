//
//  GlobalConstants.swift
//  SwiftTrade
//
//  Created by yaoliangjun on 2017/10/12.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//  全局常量

import UIKit

class GlobalConstants: NSObject {

    static let screenHeight: CGFloat = UIScreen.main.bounds.size.height
    static let screenWidth: CGFloat = UIScreen.main.bounds.size.width
    static let navigationBarHeight: CGFloat = 64
    static let tabBarHeight: CGFloat = 49
    static let tableViewHeight: CGFloat = screenHeight - navigationBarHeight
    
    // 颜色
    static let backgroundColor = AppConstants.gapColor // 页面背景颜色
}

//
//  BaseTabBarController.swift
//  SwiftTrade
//
//  Created by yaoliangjun on 2017/10/12.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//  

import UIKit

class BaseTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTabBarAppearance()
    }

    func setupTabBarAppearance() {
        // 设置背景颜色
        tabBar.barTintColor = AppConstants.tabBarColor
        // 设置字体和颜色
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont.systemFont(ofSize: 11)], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: AppConstants.goldColor, NSFontAttributeName: UIFont.systemFont(ofSize: 11)], for: .selected)
    }
}

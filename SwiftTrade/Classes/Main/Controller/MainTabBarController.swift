//
//  MainTabBarController.swift
//  SwiftTrade
//
//  Created by Jerry Yao on 2017/10/14.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//  主界面

import UIKit

class MainTabBarController: BaseTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewController()
    }

    // 设置主控制器
    func setupViewController() {
        let homeVC = HomeViewController()
        addChildViewController(childController: homeVC, title: "首页", image: "home_home_normal", selectedImage: "home_home_press")
        
        let tradeVC = TradeViewController()
        addChildViewController(childController: tradeVC, title: "交易", image: "home_transact_normal", selectedImage: "home_transact_press")
        
        let informationVC = InformationViewController()
        addChildViewController(childController: informationVC, title: "资讯", image: "home_information_normal", selectedImage: "home_information_press")
        
        let accountVC = AccountViewController()
        addChildViewController(childController: accountVC, title: "账户", image: "home_account_normal", selectedImage: "home_account_press")
    }
    
    // 添加子控制器
    func addChildViewController(childController: UIViewController, title: String, image: String, selectedImage: String) {
        childController.title = title;
        childController.tabBarItem.title = title
        childController.tabBarItem.image = UIImage(named: image)?.withRenderingMode(.alwaysOriginal)
        childController.tabBarItem.selectedImage = UIImage(named: selectedImage)?.withRenderingMode(.alwaysOriginal)
        let baseNavigationController = BaseNavigationController(rootViewController: childController)
        addChildViewController(baseNavigationController)
    }
}

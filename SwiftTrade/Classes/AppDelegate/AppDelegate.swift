//
//  AppDelegate.swift
//  SwiftTrade
//
//  Created by yaoliangjun on 2017/10/12.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        setupIQKeyboardManager()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.makeKeyAndVisible()
        
        showLoginPage()
        
        return true
    }
    
    // 显示登录页
    func showLoginPage() {
        let navigationController = BaseNavigationController(rootViewController: LoginViewController())
        window?.rootViewController = navigationController
    }
    
    // 显示主页面
    func showMainPage() {
        window?.rootViewController = MainTabBarController()
    }
    
    // 键盘管理
    func setupIQKeyboardManager() {
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().shouldResignOnTouchOutside = true
    }
}


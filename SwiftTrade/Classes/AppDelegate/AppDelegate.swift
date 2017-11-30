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

        var isFirstLaunching = UserDefaults.standard.object(forKey: AppConstants.isFirstLaunching) as? Bool
        if isFirstLaunching == nil {
            isFirstLaunching = true
        }

        if isFirstLaunching! {
            showGuidePage()

        } else {
            let token = UserDefaults.standard.object(forKey: AppConstants.token) as! String?
            guard let _ = token else {
                showLoginPage()
                return true
            }
            showMainPage()
        }

        return true
    }

    // 显示主页面
    func showMainPage() {
        window?.rootViewController = MainTabBarController()
    }

    // 显示登录页
    func showLoginPage() {
        let navigationController = BaseNavigationController(rootViewController: LoginViewController())
        window?.rootViewController = navigationController
    }

    // 退出登录
    func logout() {
        UserDefaults.standard.set("", forKey: AppConstants.token)
        let navigationController = BaseNavigationController(rootViewController: LoginViewController())
        window?.rootViewController?.present(navigationController, animated: true, completion: nil)
    }

    // 显示引导页
    func showGuidePage() {
        window?.rootViewController = GuideViewController()
    }

    // 键盘管理
    fileprivate func setupIQKeyboardManager() {
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().shouldResignOnTouchOutside = true
    }
}


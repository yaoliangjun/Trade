//
//  TradeViewController.swift
//  SwiftTrade
//
//  Created by Jerry Yao on 2017/10/14.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//  交易页面

import UIKit
import SwipeMenuViewController

class TradeViewController: SwipeMenuViewController {

    lazy var titles: [String] = ["买入", "卖出", "撤单"]
    lazy var viewControllers: [UIViewController] = {
        var viewControllers = [BuyInViewController(), SellOutViewController(), CancelOrderViewController()]
        return viewControllers
    }()

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        swipeMenuView.reloadData(options: menuOptions)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    lazy var menuOptions: SwipeMenuViewOptions = {
        var menuOptions = SwipeMenuViewOptions()
        menuOptions.tabView.backgroundColor = UIColor.white
        menuOptions.tabView.needsAdjustItemViewWidth = false
        menuOptions.tabView.itemView.width = GlobalConstants.screenWidth / 3
        menuOptions.tabView.itemView.textColor = AppConstants.greyTextColor
        menuOptions.tabView.itemView.font = UIFont.systemFont(ofSize: 16)
        menuOptions.tabView.itemView.selectedTextColor = AppConstants.greyTextColor
        menuOptions.tabView.underlineView.backgroundColor = AppConstants.goldColor

        return menuOptions
    }()

    // MARK - SwipeMenuViewDataSource
    override func numberOfPages(in swipeMenuView: SwipeMenuView) -> Int {
        return titles.count
    }

    override func swipeMenuView(_ swipeMenuView: SwipeMenuView, titleForPageAt index: Int) -> String {
        return titles[index]
    }

    override func swipeMenuView(_ swipeMenuView: SwipeMenuView, viewControllerForPageAt index: Int) -> UIViewController {
        return viewControllers[index]
    }
}

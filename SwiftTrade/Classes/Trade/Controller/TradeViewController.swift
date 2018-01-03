//
//  TradeViewController.swift
//  SwiftTrade
//
//  Created by Jerry Yao on 2017/10/14.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//  交易页面

import UIKit

class TradeViewController: PageController {

    private lazy var vcTitles: [String] = ["买入", "卖出", "撤单"]
    private lazy var viewControllers: [UIViewController] = {
        var viewControllers = [BuyInViewController(), SellOutViewController(), CancelOrderViewController()]
        return viewControllers
    }()

    // MARK: - Life cycle
    init() {
        super.init(nibName: nil, bundle: nil)
        //Do whatever you want here
        dataSource = self
        delegate = self
        menuViewStyle = .line
        menuHeight = 44
        menuBGColor = UIColor.white
        pageAnimatable = true
        progressColor = AppConstants.goldColor
        titleColorNormal = AppConstants.greyTextColor
        titleColorSelected = AppConstants.greyTextColor
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    // MARK: - PageControllerDataSource
    func numberOfControllersInPageController(_ pageController: PageController) -> Int {
        return vcTitles.count
    }

    func pageController(_ pageController: PageController, titleAtIndex index: Int) -> String {
        return vcTitles[index]
    }

    func pageController(_ pageController: PageController, viewControllerAtIndex index: Int) -> UIViewController {
        return viewControllers[index]
    }

    override func menuView(_ menuView: MenuView, widthForItemAtIndex index: Int) -> CGFloat {
        return GlobalConstants.screenWidth / 3
    }
}

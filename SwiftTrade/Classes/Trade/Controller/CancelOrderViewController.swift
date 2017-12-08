//
//  CancelOrderViewController.swift
//  SwiftTrade
//
//  Created by yaoliangjun on 2017/12/7.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//  撤单页面

import UIKit

class CancelOrderViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchCancelOrders()
    }

    // MARK: - HTTP
    func fetchCancelOrders() {
        TradeServices.fetchCancelOrders(params: [:], showHUD: true, success: { (response) in

        }) { (error) in

        }
    }

    // MARK: - Getter / Setter
    override func setupSubViews() {

    }

}

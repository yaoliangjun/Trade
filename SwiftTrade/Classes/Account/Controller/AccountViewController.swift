//
//  AccountViewController.swift
//  SwiftTrade
//
//  Created by Jerry Yao on 2017/10/14.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//  账户页面

import UIKit

class AccountViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
    }

    func setupSubViews() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "account_personal-center"), style: .plain, target: self, action: #selector(personalCenterBtnClick))

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "account_set-up"), style: .plain, target: self, action: #selector(settingBtnClick))
    }

    // MARK: - 个人中心
    func personalCenterBtnClick() {

    }

    // MARK: - 设置
    func settingBtnClick() {

    }
}

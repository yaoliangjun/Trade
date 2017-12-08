//
//  BaseViewController.swift
//  SwiftTrade
//
//  Created by yaoliangjun on 2017/10/12.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBaseViewController()
        setupSubViews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    /// 子类重写该方法设置视图
    func setupSubViews() {

    }

    /// 设置基类控制器
    private func setupBaseViewController() {
        view.backgroundColor = GlobalConstants.backgroundColor

        let count: Int? = navigationController?.viewControllers.count
        if count != nil && count! > 1 {
            // 设置导航栏返回按钮图片
            navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "global_arrow_normal", target: self, selector: #selector(popViewController))
        }
    }

    func popViewController() {
        navigationController?.popViewController(animated: true)
    }
}

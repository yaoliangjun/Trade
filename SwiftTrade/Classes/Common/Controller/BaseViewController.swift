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

        view.backgroundColor = GlobalConstants.backgroundColor

        let count: Int = (navigationController?.viewControllers.count)!
        if count > 1 {
            // 设置导航栏返回按钮图片
            navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "global_arrow_normal", target: self, selector: #selector(backBarButtonItemClick))
        }
    }

    func backBarButtonItemClick() {
        navigationController?.popViewController(animated: true)
    }
}

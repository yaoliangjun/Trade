//
//  UIBarButtonItem+Extension.swift
//  SwiftTrade
//
//  Created by yaoliangjun on 2017/11/28.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//

import Foundation

extension UIBarButtonItem {

    /// 创建一个图片导航栏按钮
    convenience init(imageName: String, target: Any?, selector: Selector) {

        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        if !imageName.isEmpty {
            let imageView = UIImageView(image: UIImage(named: imageName))
            imageView.frame = CGRect(x: 0, y: 10, width: 11, height: 20)
            btn.addSubview(imageView)
        }
        btn.addTarget(target, action: selector, for: .touchUpInside)

        self.init(customView: btn)
    }
}


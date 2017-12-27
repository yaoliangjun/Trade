//
//  CommonButton.swift
//  SwiftTrade
//
//  Created by yaoliangjun on 2017/12/27.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//

import UIKit

class CommonButton: UIButton {

    /// 通用黄色按钮
    convenience init(title: String, font: UIFont, target: Any, selector: Selector) {
        self.init(title: title, titleColor: AppConstants.greyTextColor, highlightedTitleColor: AppConstants.greyTextColor, font: font, backgroundImage: UIImage.createImage(color: AppConstants.goldColor), highlightedBackgroundImage: UIImage.createImage(color: UIColor.brown), borderWidth: 0, borderColor: nil, cornerRadius: 5, target: target, selector: selector)
    }
}

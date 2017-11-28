//
//  UIButton+Extension.swift
//  SwiftTrade
//
//  Created by yaoliangjun on 2017/10/13.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    /// 创建一个文字按钮
    convenience init(frame: CGRect, title: String, titleColor: UIColor, font: UIFont, target: Any, selector: Selector) {
        self.init(frame: frame)
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.titleLabel?.font = font
        self.addTarget(target, action: selector, for: .touchUpInside)
    }
    
    /// 创建一个文字按钮(有背景颜色、按下效果、圆角)
    convenience init(frame: CGRect, title: String, titleColor: UIColor, font: UIFont, backgroundImage: UIImage, highlightedBackgroundImage: UIImage, cornerRadius: CGFloat, target: Any, selector: Selector) {
        self.init(frame: frame, title: title, titleColor: titleColor, font: font, target: target, selector: selector)
        self.setBackgroundImage(backgroundImage, for: .normal)
        self.setBackgroundImage(highlightedBackgroundImage, for: .highlighted)
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true;
    }
    
    /// 创建一个文字按钮(有背景颜色、按下效果、圆角、边框)
    convenience init(frame: CGRect, title: String, titleColor: UIColor, font: UIFont, backgroundImage: UIImage, highlightedBackgroundImage: UIImage, cornerRadius: CGFloat, borderWidth: CGFloat, borderColor: UIColor, target: Any, selector: Selector) {
        self.init(frame: frame, title: title, titleColor: titleColor, font: font, backgroundImage: backgroundImage, highlightedBackgroundImage: highlightedBackgroundImage, cornerRadius: cornerRadius, target: target, selector: selector)
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
    }

    /// 创建一个文字按钮(有背景图片、按下效果、圆角、边框)
    convenience init(title: String, titleColor: UIColor, highlightedTitleColor: UIColor, font: UIFont, backgroundImage: UIImage, highlightedBackgroundImage: UIImage, cornerRadius: CGFloat, borderWidth: CGFloat, borderColor: UIColor?, target: Any, selector: Selector) {
        self.init()
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.setTitleColor(highlightedTitleColor, for: .highlighted)
        self.titleLabel?.font = font
        self.setBackgroundImage(backgroundImage, for: .normal)
        self.setBackgroundImage(highlightedBackgroundImage, for: .highlighted)
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor?.cgColor
        self.addTarget(target, action: selector, for: .touchUpInside)
    }

    /// 创建一个文字按钮(有背景颜色、按下效果、圆角、边框)
    convenience init(title: String, titleColor: UIColor, highlightedTitleColor: UIColor, font: UIFont, backgroundColor: UIColor, cornerRadius: CGFloat, borderWidth: CGFloat, borderColor: UIColor? = nil, target: Any, selector: Selector) {
        self.init()
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.setTitleColor(highlightedTitleColor, for: .highlighted)
        self.titleLabel?.font = font
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor?.cgColor
        self.addTarget(target, action: selector, for: .touchUpInside)
    }
}

//
//  UITextField+Extension.swift
//  SwiftTrade
//
//  Created by yaoliangjun on 2017/10/13.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    
    /// 创建一个UITextField
    convenience init(frame: CGRect, text: String, textAlignment: NSTextAlignment, textColor: UIColor, placeholder: String, placeholderColor: UIColor, font: UIFont, leftView: UIView) {
        self.init(frame: frame)
        self.text = text
        self.textAlignment = textAlignment
        self.textColor = textColor
        self.attributedPlaceholder = NSAttributedString.init(string: placeholder, attributes: [NSForegroundColorAttributeName:placeholderColor])
        self.font = font;
        self.leftView = leftView
        self.leftViewMode = .always
        self.autocorrectionType = .no
        self.autocapitalizationType = .none
    }
}

//
//  UILabel+Extension.swift
//  SwiftTrade
//
//  Created by yaoliangjun on 2017/10/13.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {

    /// 创建一个UILabel
    convenience init(frame: CGRect, text: String, textAlignment: NSTextAlignment, textColor: UIColor, font: UIFont) {        
        self.init(frame: frame)
        self.text = text
        self.textColor = textColor
        self.textAlignment = textAlignment
        self.font = font
    }
}

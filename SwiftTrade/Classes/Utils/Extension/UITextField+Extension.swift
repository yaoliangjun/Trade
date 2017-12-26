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

    /// 创建一个通用的UITextField
    convenience init(text: String?, textAlignment: NSTextAlignment?, textColor: UIColor, placeholder: String, placeholderColor: UIColor, font: UIFont) {
        self.init(frame: CGRect.zero)
        self.text = text
        if let aligment = textAlignment {
            self.textAlignment = aligment
        }
        self.textColor = textColor
        self.attributedPlaceholder = NSAttributedString.init(string: placeholder, attributes: [NSForegroundColorAttributeName:placeholderColor])
        self.font = font
        self.autocorrectionType = .no
        self.autocapitalizationType = .none
    }

    /// 创建一个UITextField(有边框、圆角)
    convenience init(text: String?, textAlignment: NSTextAlignment?, textColor: UIColor, placeholder: String, placeholderColor: UIColor, font: UIFont, borderWidth: CGFloat, borderColor: UIColor?, cornerRadius: CGFloat) {
        self.init(text: text, textAlignment: textAlignment, textColor: textColor, placeholder: placeholder, placeholderColor: placeholderColor, font: font)
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor?.cgColor
    }

    /// 创建一个UITextField(有leftView)
    convenience init(text: String?, textAlignment: NSTextAlignment?, textColor: UIColor, placeholder: String, placeholderColor: UIColor, font: UIFont, leftView: UIView, leftViewMode: UITextFieldViewMode) {
        self.init(text: text, textAlignment: textAlignment, textColor: textColor, placeholder: placeholder, placeholderColor: placeholderColor, font: font)
        self.leftView = leftView
        self.leftViewMode = leftViewMode
    }

    /// 创建一个UITextField(有边框、圆角、leftView)
    convenience init(text: String?, textAlignment: NSTextAlignment?, textColor: UIColor, placeholder: String, placeholderColor: UIColor, font: UIFont, borderWidth: CGFloat, borderColor: UIColor?, cornerRadius: CGFloat, leftView: UIView, leftViewMode: UITextFieldViewMode) {
        self.init(text: text, textAlignment: textAlignment, textColor: textColor, placeholder: placeholder, placeholderColor: placeholderColor, font: font, borderWidth: borderWidth, borderColor: borderColor, cornerRadius: cornerRadius)
        self.leftView = leftView
        self.leftViewMode = leftViewMode
    }

    /// 创建一个UITextField(有边框、圆角、rightView)
    convenience init(text: String?, textAlignment: NSTextAlignment?, textColor: UIColor, placeholder: String, placeholderColor: UIColor, font: UIFont, borderWidth: CGFloat, borderColor: UIColor?, cornerRadius: CGFloat, rightView: UIView, rightViewMode: UITextFieldViewMode) {
        self.init(text: text, textAlignment: textAlignment, textColor: textColor, placeholder: placeholder, placeholderColor: placeholderColor, font: font, borderWidth: borderWidth, borderColor: borderColor, cornerRadius: cornerRadius)
        self.rightView = rightView
        self.rightViewMode = rightViewMode
    }

    /// 创建一个UITextField(有边框、圆角、leftView、rightView)
    convenience init(text: String?, textAlignment: NSTextAlignment?, textColor: UIColor, placeholder: String, placeholderColor: UIColor, font: UIFont, borderWidth: CGFloat, borderColor: UIColor?, cornerRadius: CGFloat, leftView: UIView, leftViewMode: UITextFieldViewMode, rightView: UIView, rightViewMode: UITextFieldViewMode) {
        self.init(text: text, textAlignment: textAlignment, textColor: textColor, placeholder: placeholder, placeholderColor: placeholderColor, font: font, borderWidth: borderWidth, borderColor: borderColor, cornerRadius: cornerRadius, leftView: leftView, leftViewMode: leftViewMode)
        self.rightView = rightView
        self.rightViewMode = rightViewMode
    }

    /// 创建一个UITextField(有Frame、leftView)
    convenience init(frame: CGRect, text: String?, textAlignment: NSTextAlignment?, textColor: UIColor, placeholder: String, placeholderColor: UIColor, font: UIFont, leftView: UIView) {
        self.init(text: text, textAlignment: textAlignment, textColor: textColor, placeholder: placeholder, placeholderColor: placeholderColor, font: font)
        self.frame = frame
        self.leftView = leftView
        self.leftViewMode = .always
    }
}

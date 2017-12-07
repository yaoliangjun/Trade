//
//  ImageButton.swift
//  SwiftTrade
//
//  Created by yaoliangjun on 2017/12/5.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//  图片按钮

import UIKit

class ImageButton: UIButton {

    convenience init(title: String, titleColor: UIColor, font: UIFont, image: UIImage?, target: Any?, selector: Selector) {
        self.init()
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.titleLabel?.font = font
        self.setImage(image, for: .normal)
        self.addTarget(target, action: selector, for: .touchUpInside)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        // 修改图片的Frame
        var imageFrame = self.imageView?.frame
        let imageWidth = self.imageView?.frame.size.width
        imageFrame?.origin.x = self.frame.size.width - imageWidth!
        self.imageView?.frame = imageFrame!

        // 修改Title的Frame
        var titleFrame = self.titleLabel?.frame;
        titleFrame?.origin.x = (self.imageView?.frame.origin.x)! - (titleFrame?.size.width)! - 3
        titleFrame?.size = (self.titleLabel?.frame.size)!
        self.titleLabel?.frame = titleFrame!
    }

//    - (void)layoutSubviews
//    {
//    [super layoutSubviews];
//
//    // 修改图片的Frame
//    CGRect imageFrame = self.imageView.frame;
//    _imageWidth = self.imageView.frame.size.width;
//    imageFrame.origin.x = self.frame.size.width - _imageWidth;
//    self.imageView.frame = imageFrame;
//
//    // 修改Title的Frame
//    CGRect titleFrame = self.titleLabel.frame;
//    titleFrame.origin.x = self.imageView.x - titleFrame.size.width - 3;
//    titleFrame.size = self.titleLabel.frame.size;
//    self.titleLabel.frame = titleFrame;
//
//    if (!_btnEnable) { // 如果按钮不可用，修改Title的Frame向右偏移一点
//    CGRect titleFrame = self.titleLabel.frame;
//    titleFrame.origin.x = self.frame.size.width - titleFrame.size.width;
//    self.titleLabel.frame = titleFrame;
//    }
//    }
}


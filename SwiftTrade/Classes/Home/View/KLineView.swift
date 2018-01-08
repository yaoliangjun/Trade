//
//  KLineView.swift
//  SwiftTrade
//
//  Created by yaoliangjun on 2018/1/5.
//  Copyright © 2018年 Jerry Yao. All rights reserved.
//  K线控件

import UIKit

class KLineView: UIView {

    fileprivate var klineBtnContentView: UIView?
    fileprivate var timeLineBtn: UIButton?
    fileprivate var dayKLineBtn: UIButton?
    fileprivate var weekKLineBtn: UIButton?
    fileprivate var monthKLineBtn: UIButton?
    fileprivate var minuteKLineBtn: UIButton?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubViews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: - Private Method
    func klineBtnClick(btn: UIButton) {
        for subView in klineBtnContentView!.subviews {
            let subBtn = subView as! UIButton
            subBtn.isSelected = btn.tag == subBtn.tag
        }
    }

    // MARK: - Getter / Setter
    func setupSubViews() {

        // K线按钮父View
        klineBtnContentView = UIView()
        klineBtnContentView?.layer.borderWidth = 0.5
        klineBtnContentView?.layer.borderColor = AppConstants.greyTextColor.cgColor
        self.addSubview(klineBtnContentView!)
        klineBtnContentView!.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self)
            make.height.equalTo(35)
        }

        timeLineBtn = UIButton(title: "分时", titleColor: UIColor.white, selectedTitleColor: AppConstants.greyTextColor, font: UIFont.systemFont(ofSize: 13), backgroundImage: UIImage.createImage(color: AppConstants.greyTextColor), selectedBackgroundImage: UIImage.createImage(color: UIColor.white), target: self, selector: #selector(klineBtnClick))
        timeLineBtn?.tag = 10
        timeLineBtn?.isSelected = true

        klineBtnContentView?.addSubview(timeLineBtn!)
        timeLineBtn!.snp.makeConstraints({ (make) in
            make.top.left.height.equalTo(klineBtnContentView!)
        })

        dayKLineBtn = UIButton(title: "日K", titleColor: UIColor.white, selectedTitleColor: AppConstants.greyTextColor, font: UIFont.systemFont(ofSize: 13), backgroundImage: UIImage.createImage(color: AppConstants.greyTextColor), selectedBackgroundImage: UIImage.createImage(color: UIColor.white), target: self, selector: #selector(klineBtnClick))
        dayKLineBtn?.tag = 11
        klineBtnContentView?.addSubview(dayKLineBtn!)
        dayKLineBtn!.snp.makeConstraints({ (make) in
            make.left.equalTo(timeLineBtn!.snp.right)
            make.top.height.width.equalTo(timeLineBtn!)
        })

        weekKLineBtn = UIButton(title: "周K", titleColor: UIColor.white, selectedTitleColor: AppConstants.greyTextColor, font: UIFont.systemFont(ofSize: 13), backgroundImage: UIImage.createImage(color: AppConstants.greyTextColor), selectedBackgroundImage: UIImage.createImage(color: UIColor.white), target: self, selector: #selector(klineBtnClick))
        weekKLineBtn?.tag = 12
        klineBtnContentView?.addSubview(weekKLineBtn!)
        weekKLineBtn!.snp.makeConstraints({ (make) in
            make.left.equalTo(dayKLineBtn!.snp.right)
            make.top.height.width.equalTo(dayKLineBtn!)
        })

        monthKLineBtn = UIButton(title: "月K", titleColor: UIColor.white, selectedTitleColor: AppConstants.greyTextColor, font: UIFont.systemFont(ofSize: 13), backgroundImage: UIImage.createImage(color: AppConstants.greyTextColor), selectedBackgroundImage: UIImage.createImage(color: UIColor.white), target: self, selector: #selector(klineBtnClick))
        monthKLineBtn?.tag = 13
        klineBtnContentView?.addSubview(monthKLineBtn!)
        monthKLineBtn!.snp.makeConstraints({ (make) in
            make.left.equalTo(weekKLineBtn!.snp.right)
            make.top.height.width.equalTo(weekKLineBtn!)
        })

        minuteKLineBtn = ImageButton(title: "分钟", titleColor: UIColor.white, selectedTitleColor: AppConstants.greyTextColor, font: UIFont.systemFont(ofSize: 13), backgroundImage: UIImage.createImage(color: AppConstants.greyTextColor), selectedBackgroundImage: UIImage.createImage(color: UIColor.white), target: self, selector: #selector(klineBtnClick))
        minuteKLineBtn?.tag = 14
        minuteKLineBtn?.setImage(UIImage(named: "arrow_down_grey"), for: .normal)
        klineBtnContentView?.addSubview(minuteKLineBtn!)
        minuteKLineBtn!.snp.makeConstraints({ (make) in
            make.left.equalTo(monthKLineBtn!.snp.right)
            make.top.height.width.equalTo(monthKLineBtn!)
            make.right.equalTo(klineBtnContentView!)
        })
    }
}

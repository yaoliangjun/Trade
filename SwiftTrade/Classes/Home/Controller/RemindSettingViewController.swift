//
//  RemindSettingViewController.swift
//  SwiftTrade
//
//  Created by yaoliangjun on 2018/1/4.
//  Copyright © 2018年 Jerry Yao. All rights reserved.
//  提醒设置

import UIKit

class RemindSettingViewController: BaseViewController {

    fileprivate var currencyImageView: UIImageView?
    fileprivate var currencyNameLabel: UILabel?
    fileprivate var priceLabel: UILabel?
    fileprivate var currencyRateLabel: UILabel?

    override func setupSubViews() {
        self.title = "提醒设置"

        let contentView = UIView(backgroundColor: UIColor.white)
        view.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(15)
            make.left.right.equalTo(view)
            make.height.equalTo(227)
        }

        // 货币父View
        let currencyContentView = UIView()
        contentView.addSubview(currencyContentView)
        currencyContentView.snp.makeConstraints { (make) in
            make.left.equalTo(contentView)
            make.top.equalTo(contentView)
            make.height.equalTo(60)
        }

        // 货币图片
        currencyImageView = UIImageView(image: UIImage(named: "home_btc"))
        currencyContentView.addSubview(currencyImageView!)
        currencyImageView!.snp.makeConstraints { (make) in
            make.left.equalTo(currencyContentView).offset(10)
            make.centerY.equalTo(currencyContentView)
            make.width.height.equalTo(35)
        }

        // 货币名字
        currencyNameLabel = UILabel(text: "比特币", textColor: AppConstants.greyTextColor, font: UIFont.systemFont(ofSize: 15))
        currencyContentView.addSubview(currencyNameLabel!)
        currencyNameLabel!.snp.makeConstraints { (make) in
            make.left.equalTo(currencyImageView!.snp.right).offset(10)
            make.centerY.equalTo(currencyContentView)
            make.width.equalTo(80)
        }

        // 当前价格
        priceLabel = UILabel(text: "¥ 2598.06", textAlignment: .center, textColor: AppConstants.greyTextColor, font: UIFont.systemFont(ofSize: 15))
        contentView.addSubview(priceLabel!)
        priceLabel!.snp.makeConstraints { (make) in
            make.left.equalTo(currencyContentView.snp.right)
            make.top.width.height.equalTo(currencyContentView)
        }

        // 涨跌率
        currencyRateLabel = UILabel(text: "+215.2%", textAlignment: .center, textColor: AppConstants.greyTextColor, font: UIFont.systemFont(ofSize: 15))
        contentView.addSubview(currencyRateLabel!)
        currencyRateLabel!.snp.makeConstraints { (make) in
            make.left.equalTo(priceLabel!.snp.right)
            make.right.equalTo(contentView)
            make.top.width.height.equalTo(currencyContentView)
        }
    }
}

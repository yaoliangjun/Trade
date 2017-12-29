//
//  MarketPriceCell.swift
//  SwiftTrade
//
//  Created by yaoliangjun on 2017/12/26.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//  买卖价格Cell

import UIKit

class MarketPriceCell: CommonTableViewCell {

    private var titleLabel: UILabel?
    private var priceLabel: UILabel?
    private var volumeLabel: UILabel?

    func setupData(title: String, quoteDetailModel: QuoteDetailModel?) {

        titleLabel?.text = title

        if let quoteDetailModel = quoteDetailModel {
            priceLabel?.text = String(format: "%.5f", Float((quoteDetailModel.price)!)!)
            volumeLabel?.text = String(format: "%.2f", Float((quoteDetailModel.volume)!)!)

        } else {
            priceLabel?.text = "--"
            volumeLabel?.text = "--"
        }
    }

    override func setupSubViews() {

        titleLabel = UILabel(text: "卖1", textColor: AppConstants.greyTextColor, font: UIFont.systemFont(ofSize: 11))
        self.addSubview(titleLabel!)
        titleLabel!.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(5)
            make.top.bottom.equalTo(self)
            make.width.equalTo(35)
        }

        priceLabel = UILabel(text: "556215.00", textAlignment: .center, textColor: AppConstants.blueTextColor, font: UIFont.systemFont(ofSize: 11))
        self.addSubview(priceLabel!)
        priceLabel!.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel!.snp.right)
            make.top.bottom.equalTo(self)
        }

        volumeLabel = UILabel(text: "1.0002", textAlignment: .right, textColor: AppConstants.greyTextColor, font: UIFont.systemFont(ofSize: 11))
        self.addSubview(volumeLabel!)
        volumeLabel!.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self)
            make.left.equalTo(priceLabel!.snp.right)
            make.right.equalTo(self).offset(-5)
            make.width.equalTo(60)
        }
    }
}

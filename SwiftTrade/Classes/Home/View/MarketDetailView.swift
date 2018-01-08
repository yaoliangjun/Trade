//
//  MarketDetailView.swift
//  SwiftTrade
//
//  Created by yaoliangjun on 2018/1/5.
//  Copyright © 2018年 Jerry Yao. All rights reserved.
//  市场详情控件

import UIKit

class MarketDetailView: UIView {

    var currentPriceLabel: UILabel?
    var upDownRangeLabel: UILabel?
    var upDownValueLabel: UILabel?
    var lowPriceLabel: UILabel?
    var heightPriceLabel: UILabel?
    var volumeLabel: UILabel?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubViews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setupSubViews() {

        // 当前价格
        currentPriceLabel = UILabel(text: "0.00", textColor: AppConstants.greyTextColor, font: UIFont.systemFont(ofSize: 16))
        self.addSubview(currentPriceLabel!)
        currentPriceLabel!.snp.makeConstraints({ (make) in
            make.left.equalTo(self).offset(10)
            make.top.equalTo(self)
            make.height.equalTo(40)
        })

        // 涨跌幅
        upDownRangeLabel = UILabel(text: "-25.2%", textAlignment: .center, textColor: AppConstants.greyTextColor, font: UIFont.systemFont(ofSize: 16))
        self.addSubview(upDownRangeLabel!)
        upDownRangeLabel!.snp.makeConstraints({ (make) in
            make.left.equalTo(currentPriceLabel!.snp.right)
            make.top.width.height.equalTo(currentPriceLabel!)
        })

        // 涨跌值
        upDownValueLabel = UILabel(text: "-482.0", textAlignment: .right, textColor: AppConstants.greyTextColor, font: UIFont.systemFont(ofSize: 16))
        self.addSubview(upDownValueLabel!)
        upDownValueLabel!.snp.makeConstraints({ (make) in
            make.left.equalTo(upDownRangeLabel!.snp.right);
            make.right.equalTo(self).offset(-10)
            make.top.width.height.equalTo(upDownRangeLabel!)
        })

        // 分割线
        let lineView = UIView(backgroundColor: AppConstants.separateLineColor)
        self.addSubview(lineView)
        lineView.snp.makeConstraints({ (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(currentPriceLabel!.snp.bottom)
            make.height.equalTo(0.5)
        })

        let lowPriceText = UILabel(text: "最低价", textColor: AppConstants.greyTextColor, font: UIFont.systemFont(ofSize: 14))
        self.addSubview(lowPriceText)
        lowPriceText.snp.makeConstraints({ (make) in
            make.left.equalTo(self).offset(10)
            make.top.equalTo(lineView.snp.bottom).offset(12)
            make.height.equalTo(20)
        })

        // 最低价
        lowPriceLabel = UILabel(text: "0.00", textColor: AppConstants.greyTextColor, font: UIFont.systemFont(ofSize: 14))
        self.addSubview(lowPriceLabel!)
        lowPriceLabel!.snp.makeConstraints({ (make) in
            make.left.height.equalTo(lowPriceText)
            make.top.equalTo(lowPriceText.snp.bottom)
        })

        let heightPriceText = UILabel(text: "最高价", textAlignment: .center, textColor: AppConstants.greyTextColor, font: UIFont.systemFont(ofSize: 14))
        self.addSubview(heightPriceText)
        heightPriceText.snp.makeConstraints({ (make) in
            make.left.equalTo(lowPriceText.snp.right)
            make.top.width.height.equalTo(lowPriceText)
        })

        // 最高价
        heightPriceLabel = UILabel(text: "0.00", textAlignment: .center, textColor: AppConstants.greyTextColor, font: UIFont.systemFont(ofSize: 14))
        self.addSubview(heightPriceLabel!)
        heightPriceLabel!.snp.makeConstraints({ (make) in
            make.left.equalTo(lowPriceLabel!.snp.right)
            make.top.width.height.equalTo(lowPriceLabel!)
        })

        let volumeText = UILabel(text: "成交量", textAlignment: .right, textColor: AppConstants.greyTextColor, font: UIFont.systemFont(ofSize: 14))
        self.addSubview(volumeText)
        volumeText.snp.makeConstraints({ (make) in
            make.left.equalTo(heightPriceText.snp.right)
            make.top.width.height.equalTo(heightPriceText)
            make.right.equalTo(self).offset(-10)
        })

        // 成交量
        volumeLabel = UILabel(text: "0.00", textAlignment: .right, textColor: AppConstants.greyTextColor, font: UIFont.systemFont(ofSize: 14))
        self.addSubview(volumeLabel!)
        volumeLabel!.snp.makeConstraints({ (make) in
            make.left.equalTo(heightPriceLabel!.snp.right)
            make.top.width.height.equalTo(heightPriceLabel!)
            make.right.equalTo(volumeText)
        })
    }

}

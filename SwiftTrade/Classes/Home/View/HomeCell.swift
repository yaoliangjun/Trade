//
//  HomeCell.swift
//  SwiftTrade
//
//  Created by Jerry Yao on 2017/10/30.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class HomeCell: CommonTableViewCell {

    private var currencyImageView: UIImageView?
    private var currencyName: UILabel?
    private var currencyCode: UILabel?
    private var price: UILabel?
    private var turnoverRate: UILabel?
    private var volume: UILabel?
    private var turnover: UILabel?

    var marketSummaryModel: MarketSummaryModel? {
        didSet {
            
            currencyImageView?.kf.setImage(with: URL(string: (marketSummaryModel?.coinIcon)!))
            currencyName?.text = marketSummaryModel?.coinName;
            currencyCode?.text = marketSummaryModel?.coinSymbol?.uppercased()
            price?.text = String(format: "￥%.2f", Float((marketSummaryModel?.lastPrice)!)!)
            
            //
            var volumeStr = marketSummaryModel?.volume
            if (volumeStr?.isEmpty)! {
                volumeStr = "成交量%@0.00"
                
            } else {
                volumeStr = String(format: "成交量%.2f", Float(volumeStr!)!)
            }
            volume?.text = volumeStr

            //
            var amountStr = marketSummaryModel?.amount
            if (amountStr?.isEmpty)! {
                amountStr = "成交额%@0.00万"
                
            } else {
                amountStr = String(format: "成交额%.2f万", Float(amountStr!)!)
            }
            turnover?.text = amountStr

            //
            var changeRateStr = marketSummaryModel?.changeRate
            if (changeRateStr?.isEmpty)! {
                changeRateStr = "+0.00%"
                turnoverRate?.textColor = AppConstants.greyTextColor
                
            } else {
                let floatChangeRate: Float = Float(changeRateStr!)!
                if floatChangeRate >= 0 {
                    changeRateStr = String(format: "+%.2f%%", floatChangeRate)
                    turnoverRate?.textColor = UIColor.red
                    
                } else {
                    changeRateStr = String(format: "%.2f%%", floatChangeRate)
                    turnoverRate?.textColor = UIColor.green
                }
            }
            turnoverRate?.text = changeRateStr
        }
    }
    
    // 设置子View
    override func setupSubViews() {
        
        // 货币图片
        currencyImageView = UIImageView(image: UIImage(named: "home_btc"));
        self.contentView.addSubview(currencyImageView!)
        
        // 货币名字
        currencyName = UILabel(text: "比特币", textColor: AppConstants.greyTextColor, font: UIFont.systemFont(ofSize: 15));
        self.contentView.addSubview(currencyName!);
    
        // 货币代码
        currencyCode = UILabel(text: "BTC", textColor: AppConstants.greyTextColor, font: UIFont.systemFont(ofSize: 12));
        self.contentView.addSubview(currencyCode!);
        
        // 当前价格
        price = UILabel(text: "￥0.00", textAlignment:.center, textColor: AppConstants.greyTextColor, font: UIFont.systemFont(ofSize: 12));
        self.contentView.addSubview(price!);
        
        // 成交率
        turnoverRate = UILabel(text: "0.00%", textAlignment:.center, textColor: AppConstants.greyTextColor, font: UIFont.systemFont(ofSize: 15));
        self.contentView.addSubview(turnoverRate!);
        
        // 成交量
        volume = UILabel(text: "成交量0.00", textAlignment:.center, textColor: AppConstants.greyTextColor, font: UIFont.systemFont(ofSize: 12));
        self.contentView.addSubview(volume!);
        
        // 成交额
        turnover = UILabel(text: "成交额0.00万", textAlignment:.center, textColor: AppConstants.greyTextColor, font: UIFont.systemFont(ofSize: 12));
        self.contentView.addSubview(turnover!);
    
        currencyImageView?.snp.makeConstraints { (make) in
            make.left.equalTo(10);
            make.centerY.equalTo(self.contentView);
            make.width.height.equalTo(35);
        }
        
        currencyName?.snp.makeConstraints { (make) in
            make.left.equalTo((currencyImageView?.snp.right)!).offset(8);
            make.top.equalTo(self.contentView).offset(10);
            make.width.equalTo(70);
            make.height.equalTo(25);
        }
        
        currencyCode?.snp.makeConstraints { (make) in
            make.left.equalTo(currencyName!);
            make.top.equalTo((currencyName?.snp.bottom)!);
            make.width.height.equalTo(currencyName!);
        }

        price?.snp.makeConstraints { (make) in
            make.left.equalTo((currencyName?.snp.right)!);
            make.top.height.equalTo(currencyName!);
            make.width.equalTo(turnoverRate!);
        }
        
        turnoverRate?.snp.makeConstraints { (make) in
            make.left.equalTo((price?.snp.right)!);
            make.right.equalTo(self.contentView).offset(-10);
            make.top.height.equalTo(currencyName!);
            make.width.equalTo(price!);
        }

        volume?.snp.makeConstraints { (make) in
            make.left.equalTo(price!);
            make.top.equalTo(currencyCode!);
            make.width.equalTo(price!);
            make.height.equalTo(currencyName!);
        }
        
        turnover?.snp.makeConstraints { (make) in
            make.left.equalTo((volume?.snp.right)!);
            make.right.equalTo(self.contentView).offset(-10);
            make.top.width.height.equalTo(volume!);
        }
    }
}

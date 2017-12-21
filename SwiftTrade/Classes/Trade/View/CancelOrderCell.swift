//
//  CancelOrderCell.swift
//  SwiftTrade
//
//  Created by yaoliangjun on 2017/12/21.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//  撤单Cell

import UIKit

class CancelOrderCell: CommonTableViewCell {

    var statusImageView: UIImageView? = nil
    var coinNameLabel: UILabel? = nil
    var dateLabel: UILabel? = nil
    var quotePriceLabel: UILabel? = nil
    var quoteNumLabel: UILabel? = nil
    var volumeLabel: UILabel? = nil
    var cancelOrderBtn: UIButton? = nil
    var topLineView: UIView? = nil
    var bottomLineView: UIView? = nil

    // MARK: - Private Method
    func setupModel(cancelOrderModel: CancelOrderModel) {

        let type = cancelOrderModel.type
        if type == "BUY" {
            statusImageView?.image = UIImage(named: "account_buy")
        } else {
            statusImageView?.image = UIImage(named: "account_sell")
        }
        coinNameLabel?.text = cancelOrderModel.coinName;

        // 委托价格
        var quotePrice = "0.00000"
        if !(cancelOrderModel.price?.isEmpty)! {
            quotePrice = String(format: "%.5f", Float((cancelOrderModel.price)!)!)
        }
        quotePriceLabel?.text = quotePrice

        // 委托量
        var quoteNum = "0.00"
        if !(cancelOrderModel.volume?.isEmpty)! {
            quoteNum = String(format: "%.2f", Float((cancelOrderModel.volume)!)!)
        }
        quoteNumLabel?.text = quoteNum

        // 成交量
        var dealVolume = "0.00"
        if !(cancelOrderModel.dealVolume?.isEmpty)! {
            dealVolume = String(format: "%.2f", Float((cancelOrderModel.dealVolume)!)!)
        }
        volumeLabel?.text = dealVolume

        dateLabel?.text = NSDate.dateString(millisecond: cancelOrderModel.createdAt, formatter: "yyyy-MM-dd HH:mm")
    }

    @objc private func cancelOrderBtnClick() {

    }

    // MARK: - Getter / Setter
    override func setupCell() {
        backgroundColor = UIColor.white
    }

    override func setupSubViews() {

        statusImageView = UIImageView(image: UIImage(named: "account_buy"))
        contentView.addSubview(statusImageView!)
        statusImageView!.snp.makeConstraints({ (make) in
            make.left.equalTo(contentView).offset(15)
            make.top.equalTo(contentView).offset(10)
            make.width.height.equalTo(20)
        })

        coinNameLabel = UILabel(text: nil, textColor: AppConstants.greyTextColor, font: UIFont.systemFont(ofSize: 12))
        contentView.addSubview(coinNameLabel!)
        coinNameLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(statusImageView!.snp.right).offset(5)
            make.centerY.equalTo(statusImageView!)
            make.width.equalTo(120)
            make.height.equalTo(20)
        })

        dateLabel = UILabel(text: nil, textAlignment:.right, textColor: AppConstants.greyTextColor, font: UIFont.systemFont(ofSize: 12))
        contentView.addSubview(dateLabel!)
        dateLabel?.snp.makeConstraints({ (make) in
            make.right.equalTo(contentView).offset(-15)
            make.centerY.equalTo(coinNameLabel!)
            make.width.equalTo(120)
            make.height.equalTo(coinNameLabel!)
        })

        // 顶部分割线
        topLineView = UIView()
        topLineView?.backgroundColor = AppConstants.separateLineColor
        contentView.addSubview(topLineView!)
        topLineView?.snp.makeConstraints({ (make) in
            make.left.equalTo(contentView).offset(15)
            make.height.equalTo(0.4)
            make.right.equalTo(contentView).offset(-15)
            make.top.equalTo(statusImageView!.snp.bottom).offset(10)
        })

        // 委托价格
        let quotePrice = UILabel(text: "委托价格", textColor: AppConstants.greyTextColor, font: UIFont.systemFont(ofSize: 14))
        contentView.addSubview(quotePrice)
        quotePrice.snp.makeConstraints({ (make) in
            make.left.equalTo(statusImageView!);
            make.top.equalTo(topLineView!.snp.bottom).offset(10);
            make.height.equalTo(20);
            make.width.equalTo(100);
        })

        quotePriceLabel = UILabel(text: "0.00000", textColor: AppConstants.greyTextColor, font: UIFont.systemFont(ofSize: 14))
        contentView.addSubview(quotePriceLabel!)
        quotePriceLabel!.snp.makeConstraints({ (make) in
            make.top.equalTo(quotePrice.snp.bottom);
            make.left.width.height.equalTo(quotePrice);
        })

        // 委托量
        let quoteNum = UILabel(text: "委托量", textAlignment:.center, textColor: AppConstants.greyTextColor, font: UIFont.systemFont(ofSize: 14))
        contentView.addSubview(quoteNum)

        // 成交量
        let volume = UILabel(text: "成交量", textAlignment:.right, textColor: AppConstants.greyTextColor, font: UIFont.systemFont(ofSize: 14))
        contentView.addSubview(volume)

        quoteNum.snp.makeConstraints({ (make) in
            make.left.equalTo(quotePrice.snp.right);
            make.top.equalTo(quotePrice);
            make.width.height.equalTo(volume);
        })

        quoteNumLabel = UILabel(text: "0.00", textAlignment:.center, textColor: AppConstants.greyTextColor, font: UIFont.systemFont(ofSize: 14))
        contentView.addSubview(quoteNumLabel!)
        quoteNumLabel!.snp.makeConstraints({ (make) in
            make.left.width.height.equalTo(quoteNum);
            make.top.equalTo(quoteNum.snp.bottom);
        })

        volume.snp.makeConstraints { (make) in
            make.left.equalTo(quoteNum.snp.right);
            make.right.equalTo(contentView).offset(-15);
            make.top.width.equalTo(quoteNum);
            make.height.equalTo(20);
        }

        volumeLabel = UILabel(text: "0.00", textAlignment:.right, textColor: AppConstants.greyTextColor, font: UIFont.systemFont(ofSize: 14))
        contentView.addSubview(volumeLabel!)
        volumeLabel!.snp.makeConstraints { (make) in
            make.top.equalTo(volume.snp.bottom);
            make.left.right.width.height.equalTo(volume);
        }

        // 底部分割线
        bottomLineView = UIView()
        bottomLineView!.backgroundColor = AppConstants.separateLineColor
        contentView.addSubview(bottomLineView!)
        bottomLineView!.snp.makeConstraints({ (make) in
            make.left.right.height.equalTo(topLineView!);
            make.top.equalTo(volumeLabel!.snp.bottom).offset(8);
        })

        // 撤单
        cancelOrderBtn = UIButton(title: "撤单", titleColor: AppConstants.greyTextColor, highlightedTitleColor: AppConstants.greyTextColor, font: UIFont.systemFont(ofSize: 14), backgroundColor: AppConstants.goldColor, cornerRadius: 2, borderWidth: 0, target: self, selector: #selector(cancelOrderBtnClick))
        contentView.addSubview(cancelOrderBtn!)
        cancelOrderBtn!.snp.makeConstraints { (make) in
            make.top.equalTo(bottomLineView!.snp.bottom).offset(10);
            make.left.equalTo(contentView).offset(15);
            make.width.lessThanOrEqualTo(120);
            make.width.greaterThanOrEqualTo(60);
            make.height.equalTo(32);
        }
    }
}

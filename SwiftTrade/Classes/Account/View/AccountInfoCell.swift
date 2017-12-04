//
//  AccountInfoCell.swift
//  SwiftTrade
//
//  Created by yaoliangjun on 2017/11/28.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//

import UIKit

class AccountInfoCell: CommonTableViewCell {

    fileprivate var accountLabel: UILabel?
    fileprivate var totalAssetLabel: UILabel?
    fileprivate var totalCoinLabel: UILabel?

    // 设置数据
    func setupAssetInfo(assetModel: MyAssetModel?) {

        guard let model = assetModel else {
            return
        }

        totalAssetLabel?.text = String(format: "￥%.2f", Double(model.totalAssets!)!)
        totalCoinLabel?.text = String(format: "￥%.2f", Double(model.totalCoinAssets!)!)
    }
    
    // 设置子View
    override func setupSubViews() {

        let accountText = UILabel(text: "账号", textColor: AppConstants.greyTextColor, font: UIFont.systemFont(ofSize: 15))
        contentView.addSubview(accountText)
        accountText.snp.makeConstraints { (make) in
            make.left.equalTo(contentView).offset(10)
            make.top.equalTo(contentView)
            make.height.equalTo(50)
            make.width.lessThanOrEqualTo(80)
        }

        // 设置账号
        var account = UserDefaults.standard.object(forKey: AppConstants.account) as? NSString
        account = account ?? ""
        if account!.length >= 11 {
            account = account?.replacingCharacters(in: NSMakeRange(3, 4), with: "****") as NSString?
        }

        accountLabel = UILabel(text: account! as String, textAlignment:.right, textColor: AppConstants.greyTextColor, font: UIFont.systemFont(ofSize: 15))
        contentView.addSubview(accountLabel!)
        accountLabel!.snp.makeConstraints { (make) in
            make.left.equalTo(accountText.snp.right).offset(10)
            make.right.equalTo(contentView).offset(-10)
            make.top.equalTo(contentView)
            make.height.equalTo(accountText)
            make.width.greaterThanOrEqualTo(100)
        }

        // 分割线
        let lineView = UILabel(text: "", textColor: AppConstants.grayColor, font: UIFont.systemFont(ofSize: 15), backgroundColor: AppConstants.grayColor)
        contentView.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.left.right.equalTo(contentView)
            make.top.equalTo(accountLabel!.snp.bottom)
            make.height.equalTo(0.5)
        }

        // 总资产
        let totalAssetText = UILabel(text: "总资产", textColor: AppConstants.greyTextColor, font: UIFont.systemFont(ofSize: 15))
        contentView.addSubview(totalAssetText)

        totalAssetLabel = UILabel(text: "¥0.00", textColor: AppConstants.greyTextColor, font: UIFont.systemFont(ofSize: 15))
        contentView.addSubview(totalAssetLabel!)

        totalAssetText.snp.makeConstraints { (make) in
            make.top.equalTo(lineView.snp.bottom).offset(10)
            make.height.equalTo(25)
            make.width.lessThanOrEqualTo(80)
            make.centerX.equalTo(totalAssetLabel!)
        }

        totalAssetLabel!.snp.makeConstraints { (make) in
            make.left.equalTo(contentView).offset(10)
            make.top.equalTo(totalAssetText.snp.bottom)
            make.height.equalTo(25)
            make.width.lessThanOrEqualTo(contentView).multipliedBy(0.5)
        }

        // 币值
        let totalCoinText = UILabel(text: "币值", textColor: AppConstants.greyTextColor, font: UIFont.systemFont(ofSize: 15))
        contentView.addSubview(totalCoinText)

        totalCoinLabel = UILabel(text: "¥0.00", textColor: AppConstants.greyTextColor, font: UIFont.systemFont(ofSize: 15))
        contentView.addSubview(totalCoinLabel!)

        totalCoinText.snp.makeConstraints { (make) in
            make.top.equalTo(lineView.snp.bottom).offset(10)
            make.height.equalTo(25)
            make.width.lessThanOrEqualTo(80)
            make.centerX.equalTo(totalCoinLabel!)
        }

        totalCoinLabel!.snp.makeConstraints { (make) in
            make.right.equalTo(contentView).offset(-10)
            make.top.equalTo(totalCoinText.snp.bottom)
            make.height.equalTo(25)
            make.width.lessThanOrEqualTo(contentView).multipliedBy(0.5)
        }
    }
}

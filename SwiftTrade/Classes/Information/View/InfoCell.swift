//
//  InfoCell.swift
//  SwiftTrade
//
//  Created by yaoliangjun on 2017/11/29.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//

import UIKit

class InfoCell: CommonTableViewCell {

    var infoTitleLabel: UILabel?
    var timeLabel: UILabel?
    var infoContentLabel: UILabel?

    /// 设置数据
    func setupInfoModel(infoModel: InfoModel) {
        infoTitleLabel?.text = infoModel.title
        infoContentLabel?.text = infoModel.desc
        timeLabel?.text = NSDate.dateString(second: infoModel.addtime, formatter: "yyyy-MM-dd HH:mm")
    }

    override func setupSubViews() {

        // 资讯标题
        infoTitleLabel = UILabel(text: "", textColor: AppConstants.greyTextColor, font: UIFont.systemFont(ofSize: 14))
        contentView.addSubview(infoTitleLabel!)

        // 时间
        timeLabel = UILabel(text: "", textAlignment: .right, textColor: AppConstants.greyTextColor, font: UIFont.systemFont(ofSize: 9))
        contentView.addSubview(timeLabel!)

        // 资讯内容
        infoContentLabel = UILabel(text: "", textColor: AppConstants.greyTextColor, font: UIFont.systemFont(ofSize: 12))
        infoContentLabel?.numberOfLines = 2
        contentView.addSubview(infoContentLabel!)

        // 箭头
        let arrowImageView = UIImageView(image: UIImage(named: "arrow_right"))
        contentView.addSubview(arrowImageView)

        infoTitleLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(10);
            make.right.equalTo(timeLabel!.snp.left);
            make.top.equalTo(contentView).offset(10);
            make.height.equalTo(20);
        })

        timeLabel?.snp.makeConstraints({ (make) in
            make.right.equalTo(contentView).offset(-10);
            make.height.equalTo(15);
            make.centerY.equalTo(infoTitleLabel!);
            make.width.equalTo(90);
        })

        infoContentLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(infoTitleLabel!);
            make.top.equalTo(infoTitleLabel!.snp.bottom).offset(5);
            make.right.equalTo(contentView).offset(-50);
            make.bottom.equalTo(contentView).offset(-10);
        })

        arrowImageView.snp.makeConstraints({ (make) in
            make.right.equalTo(contentView).offset(-10);
            make.width.equalTo(8);
            make.height.equalTo(15);
            make.centerY.equalTo(infoContentLabel!);
        })
    }
}

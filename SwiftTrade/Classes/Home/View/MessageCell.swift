//
//  MessageCell.swift
//  SwiftTrade
//
//  Created by yaoliangjun on 2017/12/27.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//

import UIKit

class MessageCell: CommonTableViewCell {

    var messageImageView: UIImageView?
    var messageTitleLabel: UILabel?
    var messageContent: UILabel?
    var dateLabel: UILabel?

    override func setupSubViews() {
        // 消息图片
        messageImageView = UIImageView(image: UIImage(named: "home_system-message"))
        contentView.addSubview(messageImageView!)
        messageImageView!.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.centerY.equalTo(contentView)
            make.width.height.equalTo(30)
        }

        // 消息名称
        messageTitleLabel = UILabel(text: "系统消息", textColor: AppConstants.greyTextColor, font: UIFont.systemFont(ofSize: 13))
        contentView.addSubview(messageTitleLabel!)
        messageTitleLabel!.snp.makeConstraints { (make) in
            make.left.equalTo(messageImageView!.snp.right).offset(10)
            make.top.equalTo(contentView).offset(10)
            make.width.equalTo(150)
            make.height.equalTo(20)
        }

        // 时间
        dateLabel = UILabel(text: "2017-12-27 09:55:30", textAlignment: .right, textColor: AppConstants.greyTextColor, font: UIFont.systemFont(ofSize: 10))
        contentView.addSubview(dateLabel!)
        dateLabel!.snp.makeConstraints { (make) in
            make.left.equalTo(messageTitleLabel!.snp.right);
            make.top.equalTo(messageTitleLabel!);
            make.right.equalTo(contentView).offset(-10);
            make.height.equalTo(messageTitleLabel!);
        }

        // 消息内容
        messageContent = UILabel(text: "在过一年内，比特币价格已经上涨近2000%，最近它又急剧下挫，这一切都促使监管部门发出了特别警告。", textColor: AppConstants.greyTextColor, font: UIFont.systemFont(ofSize: 12))
        messageContent?.numberOfLines = 0
        contentView.addSubview(messageContent!)
        messageContent!.snp.makeConstraints { (make) in
            make.left.equalTo(messageTitleLabel!);
            make.top.equalTo(messageTitleLabel!.snp.bottom);
            make.right.equalTo(contentView).offset(-10);
            make.bottom.equalTo(contentView).offset(-10);
        }
    }
}

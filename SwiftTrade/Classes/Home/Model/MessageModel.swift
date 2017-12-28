//
//  MessageModel.swift
//  SwiftTrade
//
//  Created by yaoliangjun on 2017/12/28.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//

import UIKit

class MessageModel: NSObject {

    var messageId: String? // 消息ID,供本地存储消息使用
    var name: String?
    var noticeContent: String?
    var createTime: String?
    var noticeId: String?
    var status: Int = 0
    var isLook: Int = 0 // 0 未读， 1已读
}

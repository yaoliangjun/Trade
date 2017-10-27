//
//  BaseResponseModel.swift
//  SwiftTrade
//
//  Created by yaoliangjun on 2017/10/24.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//

import UIKit

class BaseResponseModel: NSObject {

    var content: Any?
    var page: Int?
    var pageNum: Int?
    var total: Int?
    var statusCode: Int?
    var errorMessage: String?
}

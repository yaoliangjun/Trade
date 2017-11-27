//
//  BaseResponseModel.swift
//  SwiftTrade
//
//  Created by yaoliangjun on 2017/10/24.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//

import UIKit

class BaseResponseModel: NSObject {

    var content: Any? = nil
    var statusCode: Int = 0
    var errorMessage: String? = nil
    var page: Int? = 0
    var pageNum: Int? = 0
    var total: Int? = 0
}

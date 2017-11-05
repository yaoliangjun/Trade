//
//  BaseServices.swift
//  SwiftTrade
//
//  Created by Jerry Yao on 2017/10/29.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//

import UIKit

class BaseServices: NSObject {

    static func processResponse(responseJSON: String?) -> BaseResponseModel? {
        guard let response = responseJSON else {
            return nil
        }
        
        let responseModel = BaseResponseModel.mj_object(withKeyValues: response)
        if responseModel?.statusCode != 0 {
            let errorMsg = responseModel?.errorMessage ?? ""
            if !errorMsg.isEmpty {
                MBProgressHUD.show(withStatus: errorMsg)
            }
            return nil
        }
        
        return responseModel!
    }
}

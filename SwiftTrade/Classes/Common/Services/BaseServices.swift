//
//  BaseServices.swift
//  SwiftTrade
//
//  Created by Jerry Yao on 2017/10/29.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//

import UIKit

class BaseServices: NSObject {

//    static func processResponse(responseJSON: Any?) -> BaseResponseModel? {
//        guard let response = responseJSON else {
//            return nil
//        }
//        
//        let responseModel = BaseResponseModel.mj_object(withKeyValues: response)
//
//        if responseModel?.statusCode == 401 {
//            // Token失效
//            let errorMsg = responseModel?.errorMessage ?? ""
//            if !errorMsg.isEmpty {
//                MBProgressHUD.show(withStatus: errorMsg)
//            }
//            
//            (UIApplication.shared.delegate as! AppDelegate).logout()
//            return nil
//
//        } else if responseModel?.statusCode != 0 {
//            let errorMsg = responseModel?.errorMessage ?? ""
//            if !errorMsg.isEmpty {
//                MBProgressHUD.show(withStatus: errorMsg)
//            }
//            return nil
//        }
//        
//        return responseModel!
//    }
}

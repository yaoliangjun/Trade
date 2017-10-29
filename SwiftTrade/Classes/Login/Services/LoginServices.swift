//
//  LoginServices.swift
//  SwiftTrade
//
//  Created by Jerry Yao on 2017/10/29.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//

import UIKit

class LoginServices: BaseServices {

    static func login(params: [String: Any], showHUD: Bool, success: @escaping (_ response: BaseResponseModel) -> (), failure: @escaping (_ error: Error) -> () ) {
        HttpManager.sharedManager.post(url: ServerUrl.loginUrl, params: params, showHUD: showHUD, success: { (response) in
            let responseModel = processResponse(responseJSON: response)
            success(responseModel)
            
        }) { (error) in
            failure(error)
        }
    }
}

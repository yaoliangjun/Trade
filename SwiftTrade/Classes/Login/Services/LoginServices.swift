//
//  LoginServices.swift
//  SwiftTrade
//
//  Created by Jerry Yao on 2017/10/29.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//

import UIKit

class LoginServices: BaseServices {

    /** 登录 */
    static func login(params: [String: Any], showHUD: Bool, success: @escaping (_ response: BaseResponseModel?) -> (), failure: @escaping (_ error: Error) -> () ) {
        HttpManager.sharedManager.post(url: ServerUrl.login, params: params, showHUD: showHUD, success: { (response) in
            let responseModel = processResponse(responseJSON: response)
            if responseModel != nil {
                success(responseModel)
            }
            
        }) { (error) in
            failure(error)
        }
    }

    /** 注册 */
    static func register(params: [String: Any], showHUD: Bool, success: @escaping (_ response: BaseResponseModel?) -> (), failure: @escaping (_ error: Error) -> () ) {
        HttpManager.sharedManager.post(url: ServerUrl.register, params: params, showHUD: showHUD, success: { (response) in
            let responseModel = processResponse(responseJSON: response)
            if responseModel != nil {
                success(responseModel)
            }
            
        }) { (error) in
            failure(error)
        }
    }
    
    /** 获取验证码 */
    static func verifyCode(params: [String: Any], showHUD: Bool, success: @escaping (_ response: BaseResponseModel?) -> (), failure: @escaping (_ error: Error) -> () ) {
        HttpManager.sharedManager.post(url: ServerUrl.verifyCode, params: params, showHUD: showHUD, success: { (response) in
            let responseModel = processResponse(responseJSON: response)
            if responseModel != nil {
                success(responseModel)
            }
            
        }) { (error) in
            failure(error)
        }
    }

    /** 找回密码 */
    static func findPassword(params: [String: Any], showHUD: Bool, success: @escaping (_ response: BaseResponseModel?) -> (), failure: @escaping (_ error: Error) -> () ) {
        HttpManager.sharedManager.post(url: ServerUrl.findPassword, params: params, showHUD: showHUD, success: { (response) in
            let responseModel = processResponse(responseJSON: response)
            if responseModel != nil {
                success(responseModel)
            }

        }) { (error) in
            failure(error)
        }
    }

    /** 获取区号 */
    static func districtNum(params: [String: Any]?, showHUD: Bool, success: @escaping (_ response: [DistrictModel]?) -> (), failure: @escaping (_ error: Error) -> ()) {
        HttpManager.sharedManager.get(url: ServerUrl.nationals, params: params, showHUD: showHUD, success: { (response) in
            let responseModel = processResponse(responseJSON: response)
            let array = DistrictModel.mj_objectArray(withKeyValuesArray: responseModel?.content) as? [DistrictModel]
            success(array)

        }) { (error) in
            
        }
    }
}

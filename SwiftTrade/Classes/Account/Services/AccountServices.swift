//
//  AccountServices.swift
//  SwiftTrade
//
//  Created by yaoliangjun on 2017/12/4.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//  账户业务类

import UIKit

class AccountServices: BaseServices {

    static func myAssets(params: [String: Any]?, showHUD: Bool, success: @escaping (_ response: MyAssetModel?) -> (), failure: @escaping (_ error: Error) -> ()) {

        HttpManager.sharedManager.get(url: ServerUrl.myAssets, params: params, showHUD: showHUD, success: { (response) in
            let responseModel = processResponse(responseJSON: response)
            let myAssetModel = MyAssetModel.mj_object(withKeyValues: responseModel?.content)
            success(myAssetModel)

        }) { (error) in
            failure(error)
        }
    }
}

//
//  HomeServices.swift
//  SwiftTrade
//
//  Created by yaoliangjun on 2017/10/24.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//

import UIKit

class HomeServices: NSObject {

    static func fetchMarketSummary(params : [String : Any], showHUD: Bool, success : @escaping (_ response : BaseResponseModel) -> (), failture : @escaping (_ error : Error) -> ()) {
        HttpManager.sharedManager.get(url: ServerUrl.marketSummary, params: params, showHUD: showHUD, success: { (response) in
            
            success(BaseResponseModel.mj_object(withKeyValues: response))
            
        }) { (error) in
            failture(error)
        }
    }
}

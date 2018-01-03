//
//  HomeServices.swift
//  SwiftTrade
//
//  Created by yaoliangjun on 2017/10/24.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//  首页业务类

import UIKit

class HomeServices: BaseServices {
    
    static func fetchMarketSummary(params : [String : Any]?, showHUD: Bool, success : @escaping (_ response : [MarketSummaryModel]) -> (), failture : ((_ error : Error?) -> ())?) {
        HttpManager.sharedManager.get(url: ServerUrl.marketSummary, params: params, showHUD: showHUD, success: { (response) in
            let array = MarketSummaryModel.mj_objectArray(withKeyValuesArray: response?.content) as! [MarketSummaryModel]
            success(array)
            
        }) { (error) in
            failture!(error)
        }
    }

    static func fetchMessages(params : [String : Any]?, showHUD: Bool, success : @escaping (_ response : [MessageModel]) -> (), failture : @escaping (_ error : Error) -> ()) {
        HttpManager.sharedManager.post(url: ServerUrl.messageList, params: params, showHUD: showHUD, success: { (response) in
            let array = MessageModel.mj_objectArray(withKeyValuesArray: response?.content) as! [MessageModel]
            success(array)

        }) { (error) in
            failture(error)
        }
    }
}

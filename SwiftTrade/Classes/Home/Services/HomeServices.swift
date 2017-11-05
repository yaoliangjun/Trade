//
//  HomeServices.swift
//  SwiftTrade
//
//  Created by yaoliangjun on 2017/10/24.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//

import UIKit

class HomeServices: BaseServices {
    
    static func fetchMarketSummary(params : [String : Any], showHUD: Bool, success : @escaping (_ response : [MarketSummaryModel]) -> (), failture : @escaping (_ error : Error) -> ()) {
        HttpManager.sharedManager.get(url: ServerUrl.marketSummary, params: params, showHUD: showHUD, success: { (response) in
            
            let responseModel = processResponse(responseJSON: response)
            let array = MarketSummaryModel.mj_objectArray(withKeyValuesArray: responseModel?.content) as! [MarketSummaryModel]
            success(array)
            
        }) { (error) in
            failture(error)
        }
    }
    
    
}

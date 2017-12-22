//
//  TradeServices.swift
//  SwiftTrade
//
//  Created by yaoliangjun on 2017/12/8.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//  交易业务类

import UIKit

class TradeServices: BaseServices {

    /** 获取撤单列表 */
    static func fetchCancelOrders(params: [String: Any]?, showHUD: Bool, success: @escaping (_ response: [CancelOrderModel]) -> (), failure: @escaping (_ error: Error) -> ()) -> Void {

        HttpManager.sharedManager.get(url: ServerUrl.cancelOrderList, params: params, showHUD: showHUD, success: { (response) in
            let array = CancelOrderModel.mj_objectArray(withKeyValuesArray: response?.content) as! [CancelOrderModel]
            success(array)

        }) { (error) in
            failure(error)
        }
    }

    /** 撤单 */
    static func cancelOrder(orderId: String, showHUD: Bool, success: @escaping (_ response: BaseResponseModel?) -> (), failure: @escaping (_ error: Error) -> ()) -> Void {

        let url = String(format: ServerUrl.cancelOrder, orderId)
        HttpManager.sharedManager.put(url: url, params: [:], showHUD: showHUD, success: { (response) in
            success(response)

        }) { (error) in
            failure(error)
        }
    }
}

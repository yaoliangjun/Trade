//
//  InfoServices.swift
//  SwiftTrade
//
//  Created by yaoliangjun on 2017/11/28.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//  资讯业务类

import UIKit

class InfoServices: BaseServices {

    static func fetchInfoList(params : [String : Any], showHUD: Bool, success : @escaping (_ response : [InfoModel]?) -> (), failture : @escaping (_ error : Error) -> ()) {
        HttpManager.sharedManager.post(url: ServerUrl.infoList, params: params, showHUD: showHUD, success: { (response) in
            let array = InfoModel.mj_objectArray(withKeyValuesArray: response?.content) as! [InfoModel]
            success(array)

        }) { (error) in
            failture(error)
        }
    }
}

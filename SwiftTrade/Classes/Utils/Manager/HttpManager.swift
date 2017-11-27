//
//  HttpManager.swift
//  SwiftTrade
//
//  Created by yaoliangjun on 2017/10/17.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

let token: String? = UserDefaults.standard.value(forKey: AppConstants.token) as? String

class HttpManager: NSObject {

    static let sharedManager: HttpManager = HttpManager()

    let headers: HTTPHeaders = [
        "Content-Type": "application/x-www-form-urlencoded",
        "token": token ?? ""
    ]
}

extension HttpManager {

    // MARK: - GET请求
    func get(url: String, params: [String: Any], showHUD: Bool, success: @escaping (_ response: Any?) -> (), failture: @escaping (_ error: Error) -> ()) {
        request(url: url, method: .get, params: params, showHUD: showHUD, success: success, failture: failture)
    }
    
    // MARK: POST请求
    func post(url: String, params: [String : Any], showHUD: Bool, success: @escaping (_ response: Any?) -> (), failture: @escaping (_ error: Error) -> ()) {
        request(url: url, method: .post, params: params, showHUD: showHUD, success: success, failture: failture)
    }

    // MARK: 请求基类
    fileprivate func request(url: String, method: HTTPMethod, params: Parameters?, showHUD: Bool, success : @escaping (_ response : Any?) -> (), failture : @escaping (_ error : Error) -> ()) -> () {

        self.showHUD(showHUD: showHUD)
        let requestUrl = ServerUrl.baseUrl + url
        Alamofire.request(requestUrl, method: method, parameters: params, headers: headers).responseJSON { (response) in

            switch response.result {

            case .success(let value):
                self.dismissHUD(showHUD: showHUD)

                let responseJson = JSON(value).rawString()

                print("REQUEST METHOD: \(method)")
                print("REQUEST URL: \(url)")
                print("REQUEST PARAMS: \(String(describing: params))")
                print("RESPONSE: \(responseJson!) \n")
                success(value)

            case .failure(let error):
                self.dismissHUD(showHUD: showHUD)
                print("HTTP REQUEST ERROR: \(error)")
                failture(error)
            }
        }
    }

    // MARK: - Private Method
    func showHUD(showHUD: Bool) {
        if showHUD {
            MBProgressHUD.showLoading()
        }
    }
    
    func dismissHUD(showHUD: Bool) {
        if showHUD {
            MBProgressHUD.dismiss()
        }
    }
}

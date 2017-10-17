//
//  HttpManager.swift
//  SwiftTrade
//
//  Created by yaoliangjun on 2017/10/17.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//

import UIKit
import Alamofire

class HttpManager: NSObject {

    static let sharedManager: HttpManager = HttpManager()
    
    let headers = [
        "Content-Type": "application/x-www-form-urlencoded"
    ]
}

extension HttpManager {
    
    // MARK: - GET请求
    func get(url: String, params : [String : Any], success : @escaping (_ response : [String : AnyObject]) -> (), failture : @escaping (_ error : Error) -> ()) {
        
        let requestUrl = ServerUrl.baseUrl + url
        print("REQUEST URL: \(requestUrl)")
        print("REQUEST PARAMS: \(params)")
        
        Alamofire.request(requestUrl, method: .get, parameters: params, headers: headers).responseJSON { (response) in

                switch response.result {

                case .success(let value):
                    success(value as! [String : AnyObject])
                    
                case .failure(let error):
                    failture(error)
                    print("HTTP REQUEST ERROR: \(error)")
                }
        }
    }
    
    // MARK: - POST请求
    func post(url: String, params : [String : Any], success : @escaping (_ response : [String : AnyObject]) -> (), failture : @escaping (_ error : Error) -> ()) {
        
        let requestUrl = ServerUrl.baseUrl + url
        print("REQUEST URL: \(requestUrl)")
        print("REQUEST PARAMS: \(params)")
        
        Alamofire.request(requestUrl, method: .post, parameters: params, headers: headers).responseJSON { (response) in
            
            switch response.result {
                
            case .success(let value):
                success(value as! [String : AnyObject])
                
            case .failure(let error):
                failture(error)
                print("HTTP REQUEST ERROR: \(error)")
            }
        }
    }
}

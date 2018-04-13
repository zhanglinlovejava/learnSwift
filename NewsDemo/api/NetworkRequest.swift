//
//  NetWorkRequest.swift
//  NewsDemo
//
//  Created by zhanglin on 2018/4/13.
//  Copyright © 2018年 zhanglin. All rights reserved.
//

import Foundation
import Alamofire
private let networkRequestInstance = NetworkRequest()
class NetworkRequest {
    class var sharedInstance :NetworkRequest{
        return networkRequestInstance
    }
    
}
extension NetworkRequest{
    func getRequest(url:String,params:[String:Any],success:@esca){
        
    }
}

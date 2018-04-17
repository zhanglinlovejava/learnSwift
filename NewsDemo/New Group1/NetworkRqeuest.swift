//
//  NetworkRqeuest.swift
//  NewsDemo
//
//  Created by zhanglin on 2018/4/17.
//  Copyright © 2018年 zhanglin. All rights reserved.
//

import Foundation
import Alamofire
open class NetworkRequest{
    static let instance = NetworkRequest()
    private init(){}
    let decoder = JSONDecoder()
    //get 请求
    func getRequest<T:Codable>(url:String,_ t:T,_ successBlock:@escaping (_ data:T)-> Void,_ errorBlock:@escaping (_ error:String) -> Void){
        request(url).responseJSON { (response) in
            if response.error == nil{
                do{
                    let reslut = try self.decoder.decode(T.self, from: response.data!)
                    successBlock(reslut)
                }catch{
                    errorBlock(error as! String)
                }
            }else{
                errorBlock(response.error as! String)
            }
        }
    }
}


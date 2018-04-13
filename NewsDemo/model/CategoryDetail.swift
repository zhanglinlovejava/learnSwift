//
//  CategoryDetail.swift
//  NewsDemo
//
//  Created by zhanglin on 2018/4/13.
//  Copyright © 2018年 zhanglin. All rights reserved.
//

import Foundation
class CategoryDetail: Codable {
    var itemList:[VideoItem]?
    var count:Int = 0
    var total:Int = 0
    var nextPageUrl:String?
    var adExist:Bool = false
}

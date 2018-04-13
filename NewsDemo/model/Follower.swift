//
//  Follow.swift
//  NewsDemo
//
//  Created by zhanglin on 2018/4/11.
//  Copyright © 2018年 zhanglin. All rights reserved.
//

import Foundation
class Follower: Codable{
    var itemList:[FollowItem]?
    var count:Int = 0
    var total:Int = 0
    var nextPageUrl:String?
    var adExist:Bool = false
}
class FollowItem: Codable {
    var type:String?
    var id:Int = 0
    var adIndex:Int = 0
    var data:FollowItemData?
}
class FollowItemData: Codable {
    var dataType:String?
    var header:Header?
    var itemList:[VideoItem]?
    var count:Int = 0
    
}

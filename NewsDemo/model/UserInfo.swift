//
//  UserInfo.swift
//  NewsDemo
//
//  Created by zhanglin on 2018/4/16.
//  Copyright © 2018年 zhanglin. All rights reserved.
//

import Foundation
class UserInfo:Codable{
    var tabInfo :RankTabList?
    var pgcInfo:PGCInfo?
}
class PGCInfo:Codable{
    var dataType:String?
    var id:Int?
    var icon:String?
    var name:String?
    var brief:String?
    var description:String?
    var actionUrl:String?
    var followCount:Int = 0
    var follow:Follow?
    var cover:Cover?
    var videoCount:Int = 0
    var shareCount:Int = 0
    var collectCount:Int = 0
    var myFollowCount:Int?
    var shield:Shield?
}


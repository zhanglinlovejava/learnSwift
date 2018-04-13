//
//  RankTabList.swift
//  NewsDemo
//
//  Created by zhanglin on 2018/4/9.
//  Copyright © 2018年 zhanglin. All rights reserved.
//

import Foundation
class Rank: Codable {
    var tabInfo:RankTabList?
}

class RankTabList:Codable {
    var tabList:[RankTab]?
    var defaultIdx:Int = 0
}
class RankTab:Codable{
    var id:Int = 0
    var name:String?
    var apiUrl:String?
}

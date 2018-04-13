//
//  Book.swift
//  NewsDemo
//
//  Created by zhanglin on 2018/4/10.
//  Copyright © 2018年 zhanglin. All rights reserved.
//

import Foundation
class News: Codable {
    var date:String?
    var stories:[Story]?
    var top_stories:[Story]?
    
}
class Story:Codable{
    var type:Int = 0
    var id:Int = 0
    var ga_prefix:String?
    var title:String?
    var images:[String]?
}


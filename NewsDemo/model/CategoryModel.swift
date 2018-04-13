//
//  CategoryModel.swift
//  NewsDemo
//
//  Created by zhanglin on 2018/4/11.
//  Copyright © 2018年 zhanglin. All rights reserved.
//

import Foundation
class CategoryModel: Codable {
    var id:Int = 0
    var name:String?
    var description:String?
    var bgPicture:String?
    var bgColor:String?
    var headerImage:String?
    var defaultAuthorId:Int = 0
}

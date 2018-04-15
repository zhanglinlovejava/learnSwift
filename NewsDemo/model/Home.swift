//
//  Home.swift
//  NewsDemo
//
//  Created by zhanglin on 2018/4/9.
//  Copyright © 2018年 zhanglin. All rights reserved.
//

import Foundation
class Home: Codable{
    var nextPageUrl:String?
    var nextPublishTime:Double?
    var newestIssueType:String?
    var issueList:[Issue]?
    
}
class Issue: Codable{
    var releaseTime:Double?
    var type:String?
    var date:Double?
    var publishTime:Double?
    var itemList:[VideoItem]?
    var count:Int = 0
}
class VideoItem: Codable {
    var type:String?
    var data:VideoData?
    var id:Int = 0
    var adIndex:Int = 0
}

class VideoData: Codable {
    var dataType:String?
    var id:Int?
    var title:String?
    var text:String?
    var actionUrl:String?
    var description:String?
    var tags:[Tag]?
    var provider:Provider?
    var category:String?
    var author:Author?
    var cover:Cover?
    var duration:Int?
    var webUrl:WebUrl?
    var releaseTime:Double?
    var playInfo:[PlayInfo]?
    var consumption:Consumption?
    var type:String?
    var remark:String?
    var date:Double?
}
class Consumption:Codable{
    var collectionCount:Int = 0
    var shareCount:Int = 0
    var replyCount:Int = 0
}
class PlayInfo: Codable {
    var height:Int = 0
    var width:Int = 0
    var urlList:[UrlList]?
    var name:String?
    var type:String?
    var url:String?
    
}
class UrlList: Codable {
    var name:String?
    var url:String?
    var size:Int = 0
}
class WebUrl: Codable {
    var raw:String?
    var forWeibo:String?
}
class Cover: Codable {
    var feed:String?
    var detail:String?
    var blurred:String?
    var homePage:String?
}
class Author: Codable {
    var id:Int = 0
    var icon:String?
    var name:String?
    var description:String?
    var latestReleaseTime:Double?
    var videoNum:Int = 0
}
class Shield: Codable {
    var itemType:String?
    var itemId:Int = 0
    var shielded:Bool?
}
class Follow: Codable {
    var itemType:String?
    var itemId:Int = 0
    var followed:Bool?
}
class Tag: Codable {
    var id:Int = 0
    var name:String?
    var actionUrl:String?
    var bgPicture:String?
    var headerImage:String?
    var tagRecType:String?
}
class Provider: Codable {
    var name:String?
    var alias:String?
    var icon:String?
}
class Header: Codable {
    var id:Int = 0
    var icon:String?
    var iconType:String?
    var title:String?
    var description:String?
    var actionUrl:String?
    var follow:Follow?
}






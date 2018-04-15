//
//  ExtensionFile.swift
//  NewsDemo
//
//  Created by zhanglin on 2018/4/13.
//  Copyright © 2018年 zhanglin. All rights reserved.
//

import UIKit
func formatSecondDuration(duration:Int) -> String{
    let minute = duration/60
    let second = duration%60
    if minute <= 9{
        if second <= 9{
            return "0\(minute)'0\(second)''"
        }else{
            return "0\(minute)'\(second)''"
        }
    }else{
        if second <= 9{
            return "\(minute)'0\(second)''"
        }else{
            return "\(minute)'\(second)''"
        }
    }
}
enum LoadDataState {
    case NORMAL,REFRESH,LOADMORE
}

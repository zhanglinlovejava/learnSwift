//
//  HotViewController.swift
//  NewsDemo
//
//  Created by zhanglin on 2018/4/8.
//  Copyright © 2018年 zhanglin. All rights reserved.
//

import UIKit
import Alamofire
class HotViewController: BasePageController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "人气榜"
        loadRankData()
        menuBar.backgroundColor = UIColor.white
        menuBar.registerClass(CustomMenuCell.self)
    }
    private func loadRankData(){
        showLoading()
        let url = "http://baobab.kaiyanapp.com/api/v4/rankList"
        request(url).responseJSON { (response) in
            self.hideLoading()
            if response.error == nil{
                do{
                    let rank = try self.decoder.decode(Rank.self, from: response.data!)
                    self.viewControllers = self.createViewControllers(list: (rank.tabInfo?.tabList)!)
                }catch{
                    print(error)
                }
            }else{
                print(response.error!)
            }
        }
    }
    private func createViewControllers(list:[RankTab]) -> [UIViewController]{
        return list.map { item -> UIViewController in
            let vc = RankListController()
            vc.apiUrl = item.apiUrl!
            vc.title = item.name
            return vc
        }
    }
    
}


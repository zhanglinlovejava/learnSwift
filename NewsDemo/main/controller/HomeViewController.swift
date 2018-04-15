//
//  HomeViewController.swift
//  NewsDemo
//
//  Created by zhanglin on 2018/4/8.
//  Copyright © 2018年 zhanglin. All rights reserved.
//

import SnapKit
import UIKit
import Alamofire
import SDWebImage
import ESPullToRefresh
class HomeViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource
{
    var tableView:UITableView!
    var videoList = [VideoItem]()
    var nextPageUrl = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "每日精选"
        setUp()
        loadData(.NORMAL)
    }
    private func setUp(){
        tableView = UITableView()
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HomeTableViewCell.classForCoder(), forCellReuseIdentifier: "home")
        tableView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(60)
            make.bottom.equalToSuperview().offset(-40)
        }
        tableView.es.addPullToRefresh {
            [unowned self] in
            self.loadData(.REFRESH)
        }
        tableView.es.addInfiniteScrolling {
            [unowned self] in
            self.loadData(.LOADMORE)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 285
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoList.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let videoVC = VideoPlayController()
        videoVC.videoId = (videoList[indexPath.row].data?.id)!
        videoVC.itemData = videoList[indexPath.row]
        self.present(videoVC, animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "home", for: indexPath) as! HomeTableViewCell
        let data = videoList[indexPath.row].data
        let url = URL(string:(data?.cover?.feed)!)
        cell.bgImage.sd_setImage(with: url, placeholderImage: nil)
        cell.titleLable.text = data?.title
        cell.avatar.sd_setImage(with: URL(string: (data?.author?.icon)!), placeholderImage: UIImage(named: "default_icon"), completed: nil)
        var tagText = "#"
        data?.tags?.forEach({ (tag) in
            tagText += tag.name! + "/"
        })
        tagText += formatSecondDuration(duration: (data?.duration)!)
        cell.tagLabel.text = tagText
        cell.categoryLabel.text = "#" + (data?.category)!
        return cell
    }
    fileprivate func loadData(_ state:LoadDataState){
        print(state)
        var url = ""
        switch state {
        case .NORMAL:
            do {
                showLoading()
                url = "http://baobab.kaiyanapp.com/api/v2/feed?"
            }
        case .LOADMORE:
            url = nextPageUrl
        case .REFRESH:
            url = "http://baobab.kaiyanapp.com/api/v2/feed?"
        }
        request(url).responseJSON { (response) in
            self.hideLoading()
            self.tableView.es.stopLoadingMore()
            self.tableView.es.stopPullToRefresh()
            if response.error == nil{
                do{
                    let home = try self.decoder.decode(Home.self, from: response.data!)
                    let temList = home.issueList![0].itemList!
                    self.nextPageUrl = home.nextPageUrl!
                    if state == .REFRESH{
                        self.videoList.removeAll()
                    }
                    for (_,item) in temList.enumerated(){
                        if item.type == "video"{
                            self.videoList.append(item)
                        }
                    }
                    print(self.videoList.count)
                    self.tableView.reloadData()
                }catch{
                    print(error)
                }
            }else{
                print(response.error!)
            }
        }
        
    }
}

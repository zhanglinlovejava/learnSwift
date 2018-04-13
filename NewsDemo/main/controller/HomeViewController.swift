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
class HomeViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource
{
    var tableView:UITableView!
    var videoList = [VideoItem]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "每日精选"
        setUp()
        loadData()
    }
    fileprivate func setUp(){
        tableView = UITableView(frame: self.view.bounds)
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HomeTableViewCell.classForCoder(), forCellReuseIdentifier: "home")
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoList.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let videoVC = VideoPlayController()
        videoVC.imageUrl = (videoList[indexPath.row].data?.cover?.feed)!
        videoVC.videoId = videoList[indexPath.row].id!
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
    fileprivate func loadData(){
        showLoading()
        let url = "http://baobab.kaiyanapp.com/api/v2/feed?"
        request(url).responseJSON { (response) in
            self.hideLoading()
            if response.error == nil{
                do{
                    let home = try self.decoder.decode(Home.self, from: response.data!)
                    let temList = home.issueList![0].itemList!
                    for (_,item) in temList.enumerated(){
                        if item.type == "video"{
                            self.videoList.append(item)
                        }
                    }
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

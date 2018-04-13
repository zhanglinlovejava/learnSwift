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
    var newsList = [Story]()
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsList.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nvc = NewsDetailViewController()
        nvc.newsId = newsList[indexPath.row].id
        self.navigationController?.pushViewController(nvc, animated: true)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "home", for: indexPath) as! HomeTableViewCell
        let url = URL(string:newsList[indexPath.row].images![0])
        cell.bgImage.sd_setImage(with: url, placeholderImage: nil)
        cell.label.text = newsList[indexPath.row].title
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    fileprivate func loadData(){
        showLoading()
        let url = "http://news-at.zhihu.com/api/4/news/latest"
        request(url).response{response in
            self.hideLoading()
            if response.error == nil{
                let news = try? self.decoder.decode(News.self, from: response.data!)
                self.newsList = (news?.stories)!
                self.tableView.reloadData()
            }else{
                print("请求失败")
            }
        }
    }
}

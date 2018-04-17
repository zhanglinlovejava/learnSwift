//
//  RankListCoontroller.swift
//  NewsDemo
//
//  Created by zhanglin on 2018/4/16.
//  Copyright © 2018年 zhanglin. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage
class RankListController:BaseViewController,UITableViewDelegate,UITableViewDataSource{
    var apiUrl = ""
    var categoryList = [VideoItem]()
    var tableView:UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    override func viewDidAppear(_ animated: Bool) {
        loadRankInfo()
    }
    private func setUI(){
        tableView  = UITableView()
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CategoryDetailCell.classForCoder(), forCellReuseIdentifier: "rank")
        tableView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(104)
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let videoVC = VideoPlayController()
        videoVC.videoId = (categoryList[indexPath.row].data?.id)!
        videoVC.itemData = categoryList[indexPath.row]
        self.present(videoVC, animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryList.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = categoryList[indexPath.row].data
        let cell = tableView.dequeueReusableCell(withIdentifier: "rank") as! CategoryDetailCell
        cell.bgImage.sd_setImage(with: URL(string:(data?.cover?.feed)!), completed: nil)
        cell.tagLabel.text = "#\((data?.category)!)/\(formatSecondDuration(duration: (data?.duration)!))"
        return cell
    }
    private func loadRankInfo(){
        showLoading()
        request(apiUrl).responseJSON { (response) in
            self.hideLoading()
            if response.error == nil{
                do{
                    let issue = try self.decoder.decode(Issue.self, from: response.data!)
                    self.categoryList = issue.itemList!
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

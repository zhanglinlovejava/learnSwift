//
//  CategoryListVController.swift
//  NewsDemo
//
//  Created by zhanglin on 2018/4/13.
//  Copyright © 2018年 zhanglin. All rights reserved.
//

import UIKit
import Alamofire
import ESPullToRefresh
import SnapKit
class CategoryListController:BaseViewController,UITableViewDelegate,UITableViewDataSource{
    var categoryId:Int = -1
    var categoryDetailList = [VideoItem]()
    var nextPageUrl = ""
    var tableView:UITableView!
    var titleStr :String = ""{
        didSet{
            self.title = oldValue
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        loadCategoryList(.NORMAL)
    }
    private func setUp(){
        tableView = UITableView()
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CategoryDetailCell.classForCoder(), forCellReuseIdentifier: "detail")
        tableView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(60)
            make.bottom.equalToSuperview().offset(-40)
        }
        tableView.es.addPullToRefresh {
            [unowned self] in
            self.loadCategoryList(.REFRESH)
        }
        tableView.es.addInfiniteScrolling {
            [unowned self] in
            self.loadCategoryList(.LOADMORE)
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detail", for: indexPath) as! CategoryDetailCell
        let item = categoryDetailList[indexPath.row].data
        cell.bgImage.sd_setImage(with: URL(string:(item?.cover?.feed)!), completed: nil)
        cell.tagLabel.text = "#\((item?.category)!)/\(formatSecondDuration(duration: (item?.duration)!))"
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let videoVC = VideoPlayController()
        videoVC.videoId = (categoryDetailList[indexPath.row].data?.id)!
        videoVC.itemData = categoryDetailList[indexPath.row]
        self.present(videoVC, animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryDetailList.count
    }
    private func loadCategoryList(_ state:LoadDataState){
        var url = ""
        switch state {
        case .NORMAL:
            do {
                showLoading()
                url = "http://baobab.kaiyanapp.com/api/v4/categories/videoList?id=\(categoryId)"
            }
        case .LOADMORE:
            url = nextPageUrl
        case .REFRESH:
            url = "http://baobab.kaiyanapp.com/api/v4/categories/videoList?id=\(categoryId)"
        }
        request(url).responseJSON(completionHandler: { (response) in
            self.hideLoading()
            self.tableView.es.stopLoadingMore()
            self.tableView.es.stopPullToRefresh()
            if response.error == nil{
                do{
                    let categoryDetail = try self.decoder.decode(CategoryDetail.self, from: response.data!)
                    if state == .REFRESH{
                        self.categoryDetailList.removeAll()
                    }
                    self.categoryDetailList.append(contentsOf: categoryDetail.itemList!)
                    self.nextPageUrl = categoryDetail.nextPageUrl!
                    self.tableView.reloadData()
                }catch{
                    print(error)
                }
            }else{
                print(response.error!)
            }
        })
    }
}

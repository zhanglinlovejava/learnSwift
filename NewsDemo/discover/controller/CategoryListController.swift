//
//  CategoryListVController.swift
//  NewsDemo
//
//  Created by zhanglin on 2018/4/13.
//  Copyright © 2018年 zhanglin. All rights reserved.
//

import UIKit
import Alamofire
import SnapKit
class CategoryListController:BaseViewController,UITableViewDelegate,UITableViewDataSource{
    var categoryId:Int = -1
    var categoryDetailList = [VideoItem]()
    var tableView:UITableView!
    var titleStr :String = ""{
        didSet{
            self.title = oldValue
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        loadCategoryList()
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
    private func loadCategoryList(){
        let url = "http://baobab.kaiyanapp.com/api/v4/categories/videoList?id=\(categoryId)"
        showLoading()
        request(url).responseJSON(completionHandler: { (response) in
            self.hideLoading()
            if response.error == nil{
                do{
                    let categoryDetail = try self.decoder.decode(CategoryDetail.self, from: response.data!)
                    self.categoryDetailList.append(contentsOf: categoryDetail.itemList!)
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

//
//  DiscoverViewController.swift
//  NewsDemo
//
//  Created by zhanglin on 2018/4/8.
//  Copyright © 2018年 zhanglin. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire
import SDWebImage
class DiscoverViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource,UICollectionViewDataSource,UICollectionViewDelegate {
    let followUrl = "http://baobab.kaiyanapp.com/api/v4/tabs/follow"
    let categoryUrl = "http://baobab.kaiyanapp.com/api/v4/categories"
    var segmentedControll:UISegmentedControl!
    var followTableView:UITableView!
    var categoryCollectionView:UICollectionView!
    var followView:UIView!
    var categoryView:UIView!
    var followList:[FollowItem] = [FollowItem]()
    var categoryList:[CategoryModel] = [CategoryModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "发现"
        setUp()
        loadFollowData()
    }
    fileprivate func setUp(){
        categoryView = UIView()
        followView = UIView()
        categoryView.isHidden = true
        followView.isHidden = false
        self.view.addSubview(followView)
        self.view.addSubview(categoryView)
        initSegmentedControll()
        initFolowView()
        initCategoryView()
    }
    fileprivate func initSegmentedControll(){
        segmentedControll = UISegmentedControl(items: ["关注","分类"])
        self.view.addSubview(segmentedControll)
        segmentedControll.selectedSegmentIndex = 0
        segmentedControll.addTarget(self, action: #selector(onSegmentValueChanged(_:)), for: .valueChanged)
        segmentedControll.tintColor = UIColor.black
        segmentedControll.setTitleTextAttributes([kCTFontAttributeName:UIFont.boldSystemFont(ofSize: 15)], for: .normal)
        segmentedControll.snp.makeConstraints { (make) in
            make.height.equalTo(30)
            make.width.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(65)
            make.centerX.equalToSuperview()
        }
        
    }
    fileprivate func initCategoryView(){
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: self.view.frame.width/2 - 1, height: self.view.frame.width/2 - 1)
        layout.minimumLineSpacing = 2  //上下间隔
        layout.minimumInteritemSpacing = 1 //左右间隔
        layout.scrollDirection = UICollectionViewScrollDirection.vertical
        categoryCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        categoryCollectionView.backgroundColor = UIColor.white
        categoryView.addSubview(categoryCollectionView)
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        categoryCollectionView.register(CategoryCell.classForCoder(), forCellWithReuseIdentifier: "category")
        categoryView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(segmentedControll.snp.bottom).offset(10)
        }
        categoryCollectionView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
        
    }
    fileprivate func initFolowView(){
        followTableView = UITableView()
        followView.addSubview(followTableView)
        followTableView.delegate = self
        followTableView.dataSource = self
        followTableView.register(FollowTableViewCell.classForCoder(), forCellReuseIdentifier: "follow")
        followView.snp.makeConstraints { (make) in
            make.right.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.top.equalTo(segmentedControll.snp.bottom).offset(10)
        }
        followTableView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return followList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "follow", for: indexPath) as! FollowTableViewCell
        let header = followList[indexPath.row].data?.header
        let url = URL(string: (followList[indexPath.row].data?.header?.icon)!)
        cell.avatar.sd_setImage(with: url, completed: nil)
        cell.title.text = header?.title
        cell.desc.text = header?.description
        cell.refreshData(itemList: (followList[indexPath.row].data?.itemList)!)
        cell.fatherController = self
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    @objc func onSegmentValueChanged(_ sender:UISegmentedControl){
        if sender.selectedSegmentIndex == 0{
            followView.isHidden = false
            categoryView.isHidden = true
            if followList.count == 0{
                loadFollowData()
            }
        }else if sender.selectedSegmentIndex == 1{
            followView.isHidden = true
            categoryView.isHidden = false
            if categoryList.count == 0{
                loadCategoryData()
            }
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 370
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryList.count
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let categoryListVC = CategoryListController()
        categoryListVC.categoryId = categoryList[indexPath.row].id
        categoryListVC.title = categoryList[indexPath.row].name
        self.navigationController?.pushViewController(categoryListVC, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: "category", for: indexPath) as! CategoryCell
        cell.bgImage.sd_setImage(with: URL(string: categoryList[indexPath.row].bgPicture!), completed: nil)
        cell.tagLabel.text = "#" + categoryList[indexPath.row].name!
        return cell
    }
    fileprivate func loadFollowData(){
        showLoading()
        request(followUrl).response { (response) in
            self.hideLoading()
            if response.error == nil{
                var follow:Follower
                do{
                    follow = try  self.decoder.decode(Follower.self, from: response.data!)
                    self.followList = follow.itemList!
                    self.followTableView.reloadData()
                }catch{
                    print(error)
                }
                
            }else{
                print("请求出错")
            }
        }
    }
    
    private func loadCategoryData(){
        showLoading()
        request(categoryUrl).response { (response) in
            self.hideLoading()
            if response.error == nil{
                do{
                    self.categoryList = try self.decoder.decode([CategoryModel].self, from: response.data!)
                    self.categoryCollectionView.reloadData()
                }catch{
                    print(error)
                }
            }else{
                print("请求出错")
            }
        }
    }
}


//
//  MyViewController.swift
//  NewsDemo
//
//  Created by zhanglin on 2018/4/8.
//  Copyright © 2018年 zhanglin. All rights reserved.
//

import UIKit
import Alamofire
class MyViewController: BaseViewController {
    var avatarImage:UIImageView!
    var nameLabel:UILabel!
    var userInfo:UserInfo?
    var setItemOffset = 30
    var horLine:UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我"
        setUp()
        loadInfo()
    }
    
    private func setUp(){
        let viewInfoBtn = UIButton()
        let collectionImage = UIImageView()
        let collectionLabel = UILabel()
        let grayLine = UIView()
        horLine = UILabel()
        avatarImage = UIImageView()
        nameLabel = UILabel()
        let commentImage = UIImageView()
        let commentLabel = UILabel()
        self.view.addSubview(avatarImage)
        self.view.addSubview(nameLabel)
        self.view.addSubview(viewInfoBtn)
        self.view.addSubview(collectionImage)
        self.view.addSubview(collectionLabel)
        self.view.addSubview(commentImage)
        self.view.addSubview(commentLabel)
        self.view.addSubview(grayLine)
        self.view.addSubview(horLine)
        viewInfoBtn.setTitle("查看个人主页", for: .normal)
        viewInfoBtn.setTitleColor(UIColor.gray, for: .normal)
        viewInfoBtn.addTarget(self, action: #selector(onViewInfoClick(_:)), for: .touchUpInside)
        avatarImage.image = UIImage(named: "default_icon")
        nameLabel.textColor = UIColor.black
        collectionImage.image = UIImage(named: "heart_gray")
        collectionLabel.textColor = UIColor.gray
        collectionLabel.text = "收藏"
        commentImage.image = UIImage(named: "comment_gray")
        commentLabel.textColor = UIColor.gray
        commentLabel.text = "评论"
        grayLine.backgroundColor = UIColor.gray
        horLine.backgroundColor = UIColor.gray
        horLine.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(grayLine.snp.bottom).offset(20)
            make.height.equalTo(0.5)
        }
        grayLine.snp.makeConstraints { (make) in
            make.width.equalTo(0.5)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.centerY.equalTo(collectionImage)
        }
        avatarImage.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(120)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(80)
        }
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(avatarImage.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
        }
        viewInfoBtn.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
        collectionImage.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(80)
            make.top.equalTo(viewInfoBtn.snp.bottom).offset(40)
            make.width.height.equalTo(20)
        }
        collectionLabel.snp.makeConstraints { (make) in
            make.left.equalTo(collectionImage.snp.right).offset(10)
            make.centerY.equalTo(collectionImage)
        }
        commentLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-80)
            make.centerY.equalTo(commentImage)
        }
        commentImage.snp.makeConstraints { (make) in
            make.right.equalTo(commentLabel.snp.left).offset(-10)
            make.centerY.equalTo(collectionImage)
        }
        createSetItem("我的栏目")
        createSetItem("我的消息")
        createSetItem("我的关注")
        createSetItem("我的缓存")
        createSetItem("观看记录")
        createSetItem("意见反馈")
    }
    private func createSetItem(_ title:String){
        let btn = UIButton()
        self.view.addSubview(btn)
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(UIColor.gray, for: .normal)
        btn.addTarget(self, action: #selector(onSetItemClick(_:)), for: .touchUpInside)
        btn.snp.makeConstraints { (make) in
            make.top.equalTo(horLine.snp.bottom).offset(setItemOffset)
            make.centerX.equalToSuperview()
        }
        setItemOffset += 40 + Int(btn.frame.height)
    }
    @objc func onSetItemClick(_ sender:UIButton){
        let title = sender.title(for: .normal)
        switch title {
        case "我的栏目":
            print(title!)
        case "我的消息":
            print(title!)
        case "我的关注":
            print(title!)
        case "我的缓存":
            print(title!)
        case "观看记录":
            print(title!)
        case "意见反馈":
            print(title!)
        default: break
            
        }
    }
    private func initData(){
        nameLabel.text = userInfo?.pgcInfo?.name ?? "姓名"
        avatarImage.sd_setImage(with:URL(string: (userInfo?.pgcInfo?.icon)!) , completed: nil)
    }
    @objc func onViewInfoClick(_ sender:UIButton){
        print("个人主页")
    }
    private func loadInfo(){
        showLoading()
        let url = "http://baobab.kaiyanapp.com/api/v4/pgcs/detail/tab?id=571"
        NetworkRequest.instance.getRequest(url: url,UserInfo(), { (result) in
            self.hideLoading()
            self.userInfo  = result
            self.initData()
        }) { (error) in
            self.hideLoading()
            print(error)
        }
//        request(url).responseJSON { (response) in
//            self.hideLoading()
//            if response.error == nil{
//                do{
//                    self.userInfo = try self.decoder.decode(UserInfo.self, from: response.data!)
//                    self.initData()
//                }catch{
//                    print(error)
//                }
//            }else {
//                print(response.error!)
//            }
//        }
    }
}

//
//  VideoDetailHeaderView.swift
//  NewsDemo
//
//  Created by 张林 on 2018/4/14.
//  Copyright © 2018年 zhanglin. All rights reserved.
//

import UIKit
import AVKit
class VideoAuthorView: UIView {
    let avatarImage = UIImageView()
    let nameLabel = UILabel()
    let descLabel = UILabel()
    let followBtn = UIButton()
    var player = AVPlayerViewController()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(avatarImage)
        self.addSubview(nameLabel)
        self.addSubview(descLabel)
        self.addSubview(followBtn)
        setUp()
        makeConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func makeConstraints(){
        avatarImage.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.width.equalTo(50)
        }
       
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(avatarImage.snp.right).offset(20)
            make.top.equalTo(avatarImage).offset(5)
            make.width.equalTo(UIScreen.main.bounds.width - 180)
        }
        descLabel.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel)
            make.bottom.equalTo(avatarImage)
            make.width.equalTo(nameLabel)
        }
        followBtn.snp.makeConstraints { (make) in
            make.left.equalTo(descLabel.snp.right).offset(20)
            make.centerY.equalTo(avatarImage)
            make.width.equalTo(60)
        }
    }
    private func setUp(){
        nameLabel.textColor = UIColor.white
        nameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        descLabel.textColor = UIColor.lightGray
        descLabel.font = UIFont.boldSystemFont(ofSize: 14)
        followBtn.setTitleColor(UIColor.white, for: .normal)
        followBtn.clipsToBounds  = true
        followBtn.layer.borderColor = UIColor.white.cgColor
        followBtn.layer.borderWidth = 1
        followBtn.layer.cornerRadius = 10
        followBtn.setTitle("+ 关注", for: .normal)
        followBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
    }
    @objc func onFollowBtnClick(_ sender:UIButton){
        followBtn.setTitle( followBtn.title(for: .normal) == "已关注" ? "+ 关注" : "已关注", for: .normal)
    }
    func initData(author:Author,url:String){
        player.player = AVPlayer(url: URL(string: url)!)
        avatarImage.sd_setImage(with: URL(string: author.icon!), completed: nil)
        nameLabel.text = author.name
        descLabel.text = author.description
        followBtn.addTarget(self, action: #selector(onFollowBtnClick(_:)), for: .touchUpInside)
    }
}

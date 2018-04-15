//
//  VideoInfoCell.swift
//  NewsDemo
//
//  Created by zhanglin on 2018/4/13.
//  Copyright © 2018年 zhanglin. All rights reserved.
//

import UIKit
class VideoInfoCardCell: UITableViewCell {
    let titleLable = UILabel()
    let tagLabel = UILabel()
    let descLabel = UILabel()
    let heartImage = UIImageView()
    let heartCountLabel = UILabel()
    let shareImage = UIImageView()
    let shareCountLabel =  UILabel()
    let commentImage = UIImageView()
    let commentCountLabel = UILabel()
    let cacheImage = UIImageView()
    let cacheLabel = UILabel()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        self.contentView.addSubview(titleLable)
        self.contentView.addSubview(tagLabel)
        self.contentView.addSubview(descLabel)
        self.contentView.addSubview(heartImage)
        self.contentView.addSubview(heartCountLabel)
        self.contentView.addSubview(shareImage)
        self.contentView.addSubview(shareCountLabel)
        self.contentView.addSubview(commentImage)
        self.contentView.addSubview(commentCountLabel)
        self.contentView.addSubview(cacheImage)
        self.contentView.addSubview(cacheLabel)
        makeConstraints()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setUI(){
        heartImage.image = UIImage(named: "heart")
        shareImage.image = UIImage(named: "share")
        commentImage.image = UIImage(named: "comment")
        cacheImage.image = UIImage(named: "cache")
        cacheLabel.text = "缓存"
        titleLable.textColor = UIColor.white
        descLabel.textColor = UIColor.white
        tagLabel.textColor = UIColor.white
        shareCountLabel.textColor = UIColor.white
        heartCountLabel.textColor = UIColor.white
        commentCountLabel.textColor = UIColor.white
        cacheLabel.textColor = UIColor.white
        descLabel.numberOfLines = 4
        descLabel.font = UIFont.boldSystemFont(ofSize: 15)
        titleLable.sizeToFit()
        tagLabel.sizeToFit()
        descLabel.sizeToFit()
        shareCountLabel.sizeToFit()
        commentCountLabel.sizeToFit()
        heartCountLabel.sizeToFit()
        cacheLabel.sizeToFit()
    }
    private func makeConstraints(){
        titleLable.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-20)
        }
        tagLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(titleLable)
            make.top.equalTo(titleLable.snp.bottom).offset(10)
        }
        descLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(titleLable)
            make.top.equalTo(tagLabel.snp.bottom).offset(10)
        }
        heartImage.snp.makeConstraints { (make) in
            make.left.equalTo(titleLable)
            make.top.equalTo(descLabel.snp.bottom).offset(10)
            make.bottom.equalTo(-10)
        }
        heartCountLabel.snp.makeConstraints { (make) in
            make.left.equalTo(heartImage.snp.right).offset(10)
            make.centerY.equalTo(heartImage)
        }
        shareImage.snp.makeConstraints { (make) in
            make.left.equalTo(heartCountLabel.snp.right).offset(30)
            make.top.equalTo(heartImage)
            make.bottom.equalTo(-10)
        }
        shareCountLabel.snp.makeConstraints { (make) in
            make.left.equalTo(shareImage.snp.right).offset(10)
            make.top.equalTo(heartCountLabel)
        }
        commentImage.snp.makeConstraints { (make) in
            make.left.equalTo(shareCountLabel.snp.right).offset(30)
            make.top.equalTo(shareImage)
            make.bottom.equalTo(-10)
        }
        commentCountLabel.snp.makeConstraints { (make) in
            make.left.equalTo(commentImage.snp.right).offset(10)
            make.top.equalTo(shareCountLabel)
        }
        cacheImage.snp.makeConstraints { (make) in
            make.left.equalTo(commentCountLabel.snp.right).offset(30)
            make.top.equalTo(commentImage)
            make.bottom.equalTo(-10)
        }
        cacheLabel.snp.makeConstraints { (make) in
            make.left.equalTo(cacheImage.snp.right).offset(10)
            make.top.bottom.equalTo(commentCountLabel)
        }
        
        
    }
    
}

//
//  HomeTableViewCell.swift
//  NewsDemo
//
//  Created by zhanglin on 2018/4/9.
//  Copyright © 2018年 zhanglin. All rights reserved.
//

import UIKit
import SnapKit
class HomeTableViewCell: UITableViewCell {
    let bgImage = UIImageView()
    let tagLabel = UILabel()
    let avatar = UIImageView()
    let titleLable = UILabel()
    let categoryLabel = UILabel()
    let infoView = UIView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        self.contentView.addSubview(bgImage)
        infoView.addSubview(avatar)
        infoView.addSubview(tagLabel)
        infoView.addSubview(titleLable)
        infoView.addSubview(categoryLabel)
        self.contentView.addSubview(infoView)
        makeConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setUI(){
        tagLabel.textColor = UIColor.gray
        titleLable.textColor = UIColor.black
        categoryLabel.textColor = UIColor.gray
        categoryLabel.sizeToFit()
        tagLabel.font = UIFont.boldSystemFont(ofSize: 15)
    }
    func makeConstraints(){
        bgImage.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(220)
        }
        infoView.snp.makeConstraints { (make) in
            make.left.right.equalTo(bgImage)
            make.top.equalTo(bgImage.snp.bottom)
            make.bottom.equalToSuperview()
        }
        
        avatar.snp.makeConstraints { (make) in
            make.left.top.equalTo(infoView).offset(10)
            make.bottom.equalTo(infoView).offset(-10)
            make.width.equalTo(avatar.snp.height)
        }
       
        titleLable.snp.makeConstraints { (make) in
            make.left.equalTo(avatar.snp.right).offset(20)
            make.top.equalTo(infoView).offset(10)
        }
        tagLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLable)
            make.width.equalTo(titleLable)
            make.bottom.equalTo(infoView).offset(-10)
        }
        categoryLabel.snp.makeConstraints { (make) in
            make.right.equalTo(infoView).offset(-10)
            make.left.greaterThanOrEqualTo(titleLable.snp.right).offset(20)
            make.centerY.equalTo(infoView)
            make.width.equalTo(60)
        }
    }
}

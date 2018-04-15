//
//  HorizontalCell.swift
//  NewsDemo
//
//  Created by zhanglin on 2018/4/11.
//  Copyright © 2018年 zhanglin. All rights reserved.
//

import UIKit
class HorizontalCell:UICollectionViewCell{
    let horImage = UIImageView()
    let horTitle = UILabel()
    let horTag = UILabel()
    var itemList = [VideoItem]()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        self.contentView.addSubview(horImage)
        self.contentView.addSubview(horTitle)
        self.contentView.addSubview(horTag)
        makeHorConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    fileprivate func setUI(){
        horTitle.textColor = UIColor.black
        horTag.textColor = UIColor.black
    }
    fileprivate func makeHorConstraints(){
        horImage.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview()
            make.width.equalToSuperview().offset(-20)
            make.height.equalTo(200)
        }
        horTitle.snp.makeConstraints { (make) in
            make.top.equalTo(horImage.snp.bottom).offset(20)
            make.left.equalTo(horImage)
            make.width.equalTo(horImage)
        }
        horTag.snp.makeConstraints { (make) in
            make.left.equalTo(horTitle)
            make.top.equalTo(horTitle.snp.bottom).offset(5)
            make.width.equalTo(horImage)
            make.bottom.equalTo(-10)
        }
      
    }
}

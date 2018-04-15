//
//  VideoSmallCardCell.swift
//  NewsDemo
//
//  Created by zhanglin on 2018/4/13.
//  Copyright © 2018年 zhanglin. All rights reserved.
//

import UIKit
class VideoSmallCardCell: UITableViewCell {
    let bgImage = UIImageView()
    let titleLabel = UILabel()
    let tagLabel = UILabel()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        self.contentView.addSubview(bgImage)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(tagLabel)
        makeConstriants()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setUI(){
        titleLabel.textColor = UIColor.white
        titleLabel.numberOfLines = 2
        tagLabel.font = UIFont.boldSystemFont(ofSize: 20)
        tagLabel.textColor = UIColor.lightGray
        tagLabel.font = UIFont.boldSystemFont(ofSize: 16)
    }
    private func makeConstriants(){
        bgImage.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview()
            make.width.equalTo(160)
            make.height.equalTo(85)
            make.bottom.equalTo(-10)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(bgImage.snp.right).offset(10)
            make.top.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-10)
        }
        tagLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.bottom.equalTo(bgImage).offset(-10)
        }
    }
}

//
//  CategoryDetailCell.swift
//  NewsDemo
//
//  Created by zhanglin on 2018/4/13.
//  Copyright © 2018年 zhanglin. All rights reserved.
//

import UIKit
class CategoryDetailCell: UITableViewCell {
    let bgImage = UIImageView()
    let tagLabel = UILabel()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        self.contentView.addSubview(bgImage)
        self.contentView.addSubview(tagLabel)
        makeConstraints()
    }
    private func setUI(){
        let bgColor = UIColor(white: 0.2, alpha: 0.5)
        tagLabel.backgroundColor = bgColor
        tagLabel.textColor = UIColor.white
        tagLabel.textAlignment = NSTextAlignment.center
        tagLabel.font = UIFont.boldSystemFont(ofSize: 25)
        
    }
    
    private func makeConstraints(){
        bgImage.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
        tagLabel.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(bgImage)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

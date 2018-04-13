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
    let label = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        self.contentView.addSubview(bgImage)
        self.contentView.addSubview(label)
        makeConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setUI(){
        label.numberOfLines = 2
    }
    func makeConstraints(){
        bgImage.snp.makeConstraints { (make) in
            make.right.bottom.equalToSuperview().offset(-10)
            make.top.equalTo(self.contentView).offset(10)
            make.width.equalTo(80)
        }
        label.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(bgImage)
            make.left.equalToSuperview().offset(10)
            make.height.equalTo(bgImage)
            make.right.equalTo(bgImage.snp.left).offset(-10)
        }
    }
}

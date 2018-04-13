//
//  FollowListCell.swift
//  NewsDemo
//
//  Created by zhanglin on 2018/4/11.
//  Copyright © 2018年 zhanglin. All rights reserved.
//

import UIKit
class FollowListCell: UITableViewCell {
    let bgImage = UIImageView()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        self.contentView.addSubview(bgImage)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setUI(){
        
    }
    func makeConstraints(){
        bgImage.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalTo(250)
            make.bottom.equalTo(-11)
        }
    }
    
}

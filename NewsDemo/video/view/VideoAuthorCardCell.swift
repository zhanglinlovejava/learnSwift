//
//  VideoAuthorCardCell.swift
//  NewsDemo
//
//  Created by zhanglin on 2018/4/13.
//  Copyright © 2018年 zhanglin. All rights reserved.
//

import UIKit
import SnapKit
class VideoAuthorCardCell: UITableViewCell {
    let tagLabel = UILabel()
    let avatar = UIImageView()
    let titleLable = UILabel()
    let followBtn = UIButton()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        self.contentView.addSubview(avatar)
        self.contentView.addSubview(titleLable)
        self.contentView.addSubview(tagLabel)
        self.contentView.addSubview(followBtn)
        makeConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setUI(){
    }
    private func makeConstraints(){
        avatar.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(20)
            make.width.height.equalTo(40)
        }
    }
    
}

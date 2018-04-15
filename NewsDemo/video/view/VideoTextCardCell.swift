//
//  VideoTextCardCell.swift
//  NewsDemo
//
//  Created by zhanglin on 2018/4/13.
//  Copyright © 2018年 zhanglin. All rights reserved.
//

import UIKit
class VideoTextCardCell: UITableViewCell {
    let label = UILabel()
    let arrow = UIImageView()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        self.contentView.addSubview(label)
        self.contentView.addSubview(arrow)
        makeConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setUI(){
        label.textColor  = UIColor.white
    }
    private func makeConstraints(){
        label.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
        }
        arrow.snp.makeConstraints { (make) in
            make.left.equalTo(label.snp.right).offset(10)
            make.centerY.equalToSuperview()
            make.width.equalTo(20)
            make.height.equalTo(30)
        }
    }
}

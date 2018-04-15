//
//  CategoryCell.swift
//  NewsDemo
//
//  Created by zhanglin on 2018/4/12.
//  Copyright © 2018年 zhanglin. All rights reserved.
//

import UIKit
import DynamicColor
class CategoryCell: UICollectionViewCell {
    let bgImage = UIImageView()
    let tagLabel = UILabel()
    override init(frame:CGRect) {
        super.init(frame: frame)
        setUI()
        self.contentView.addSubview(bgImage)
        self.contentView.addSubview(tagLabel)
        makeConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    fileprivate func setUI(){
        let bgColor = UIColor(white: 0.2, alpha: 0.5)
        tagLabel.backgroundColor = bgColor
        tagLabel.textColor = UIColor.white
        tagLabel.textAlignment = NSTextAlignment.center
        tagLabel.font = UIFont.boldSystemFont(ofSize: 20)
        setCorner(10, bgImage)
        setCorner(10, tagLabel)
    }
    fileprivate func makeConstraints(){
        bgImage.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
        tagLabel.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
    private func setCorner(_ corner:CGFloat,_ view:UIView){
        view.clipsToBounds = true
        view.layer.cornerRadius = corner
    }
    
}

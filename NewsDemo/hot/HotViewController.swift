//
//  HotViewController.swift
//  NewsDemo
//
//  Created by zhanglin on 2018/4/8.
//  Copyright © 2018年 zhanglin. All rights reserved.
//

import UIKit
import SnapKit
class HotViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let view1 = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        view1.backgroundColor = UIColor.magenta
        view1.center = self.view.center
        self.view.addSubview(view1)
        let view2 = UIView()
        view2.backgroundColor = UIColor.blue
        view1.addSubview(view2)
        view2.snp.makeConstraints { (make) in
           //让顶部距离view1 的底部距离为10
            make.top.equalTo(view1.snp.bottom).offset(10)
            //设置宽和高
            make.width.height.equalTo(100)
            //水平中心线小于等于view1的左边
//            make.centerX.lessThanOrEqualTo(view1.snp.leading)
            //view2的左边大于等于view1的左边
            make.left.greaterThanOrEqualTo(view1.snp.left)
        }
    }
}

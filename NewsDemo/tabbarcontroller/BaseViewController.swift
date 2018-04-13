//
//  BaseViewController.swift
//  NewsDemo
//
//  Created by zhanglin on 2018/4/10.
//  Copyright © 2018年 zhanglin. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
class BaseViewController: ViewController {
    var loadingView:NVActivityIndicatorView!
    lazy var decoder : JSONDecoder = {
        return JSONDecoder()
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
    }
    func addRightItem(_ rightText:String){
        let rightItem = UIBarButtonItem(title:rightText,style: UIBarButtonItemStyle.plain, target: self,action:#selector(onRightClick))
        self.navigationItem.rightBarButtonItem = rightItem
    }
    func addRightImage(imageName:String){
        let rightItem = UIBarButtonItem(image: UIImage(named: imageName), style: UIBarButtonItemStyle.plain, target: self, action: #selector(onRightClick))
        self.navigationItem.rightBarButtonItem = rightItem
    }
    @objc func onRightClick(){
        
    }
    
    func showLoading(){
        if loadingView == nil {
            loadingView = NVActivityIndicatorView(frame: CGRect(), type: NVActivityIndicatorType.ballBeat, color: UIColor.red, padding: 0)
            self.view.addSubview(loadingView)
            loadingView.snp.makeConstraints { (make) in
                make.width.height.equalTo(60)
                make.center.equalToSuperview()
            }
        }
        loadingView.startAnimating()
    }
    func hideLoading(){
        if loadingView != nil{
            loadingView.stopAnimating()
        }
    }
    
}

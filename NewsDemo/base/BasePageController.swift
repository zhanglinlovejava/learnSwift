//
//  BasePageController.swift
//  NewsDemo
//
//  Created by zhanglin on 2018/4/16.
//  Copyright © 2018年 zhanglin. All rights reserved.
//

import UIKit
import PageController
import NVActivityIndicatorView
class  BasePageController: PageController {
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
    func addGobackButton(){
        let backBtn = UIButton()
        backBtn.setBackgroundImage(UIImage(named: "back"), for: .normal)
        self.view.addSubview(backBtn)
        backBtn.addTarget(self, action: #selector(goback), for: .touchUpInside)
        backBtn.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(20)
        }
        
    }
    
    @objc func goback(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func showLoading(){
        if loadingView == nil {
            loadingView = NVActivityIndicatorView(frame: CGRect.zero, type: NVActivityIndicatorType.ballClipRotatePulse, color: UIColor.magenta, padding: 0)
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
class CustomMenuCell: MenuCell {

    required init(frame: CGRect) {
        super.init(frame: frame)
        contentInset = UIEdgeInsets(top: 10, left: 40, bottom: 10, right: 40)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func updateData() {
        super.updateData()
        titleLabel.textColor = selected ? UIColor.black : UIColor.gray
    }
}

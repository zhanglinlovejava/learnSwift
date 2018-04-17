//
//  MainViewController.swift
//  NewsDemo
//
//  Created by zhanglin on 2018/4/8.
//  Copyright © 2018年 zhanglin. All rights reserved.
//

import UIKit
class TabbarViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        addChildVC(childVC: HomeViewController(), childTitle: "每日精选", imageName: "home_normal", selectImageName: "home_selected")
        addChildVC(childVC: DiscoverViewController(), childTitle: "发现", imageName: "dicover_normal", selectImageName: "discover_selected")
        addChildVC(childVC: HotViewController(), childTitle: "热门", imageName: "hot_normal", selectImageName: "hot_selected")
        addChildVC(childVC: MyViewController(), childTitle: "我的", imageName: "mine_normal", selectImageName: "mine_selected")
        self.tabBar.tintColor = UIColor.black
    }
    
    
    
    private func addChildVC(childVC:UIViewController,childTitle:String,imageName:String,selectImageName:String){
        let navigation = UINavigationController(rootViewController: childVC)
        navigation.tabBarItem = UITabBarItem(title: childTitle, image: UIImage(named: imageName), selectedImage: UIImage(named: selectImageName))
        self.addChildViewController(navigation)
    }
}

//
//  FollowListController.swift
//  NewsDemo
//
//  Created by zhanglin on 2018/4/11.
//  Copyright © 2018年 zhanglin. All rights reserved.
//

import UIKit
import SDWebImage
class FollowListController: BaseViewController,UITableViewDataSource,UITableViewDelegate {
    var tableView:UITableView = UITableView()
    var folowTitle = ""{
        didSet{
            self.title = oldValue
        }
    }
    var followList:[VideoItem] = [VideoItem]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    func setUI(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(classForCoder, forCellReuseIdentifier: "list")
        self.view.addSubview(tableView)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return followList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "list", for: indexPath) as! FollowListCell
        cell.bgImage.sd_setImage(with: URL(string: (followList[indexPath.row].data?.cover?.feed)!), completed: nil)
        return cell
    }
}

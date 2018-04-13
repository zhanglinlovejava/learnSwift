//
//  VideoPlayController.swift
//  NewsDemo
//
//  Created by zhanglin on 2018/4/13.
//  Copyright © 2018年 zhanglin. All rights reserved.
//

import UIKit
import Alamofire
class VideoPlayController:BaseViewController,UITableViewDelegate,UITableViewDataSource{
    var tableView:UITableView!
    var videoView:UIImageView!
    var videoId:Int = -1
    var imageUrl = ""
    var itemData = VideoItem()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        addGobackButton()
    }
    
    private func setUp(){
        videoView = UIImageView()
        self.view.addSubview(videoView)
        videoView.sd_setImage(with: URL(string: imageUrl), completed: nil)
        tableView = UITableView()
        tableView.delegate  = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        tableView.register(VideoSmallCardCell.classForCoder(), forCellReuseIdentifier: "video")
        videoView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(220)
        }
        tableView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(videoView.snp.bottom)
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "video", for: indexPath) as! VideoSmallCardCell
        return cell
    }
}

//
//  VideoPlayController.swift
//  NewsDemo
//
//  Created by zhanglin on 2018/4/13.
//  Copyright © 2018年 zhanglin. All rights reserved.
//

import UIKit
class VideoPlayController:BaseViewController,UITableViewDelegate,UITableViewDataSource{
    var tableView:UITableView!
    var videoView:UIImageView!
    var imageUrl:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
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
        let backBtn = UIButton()
        backBtn.setBackgroundImage(UIImage(named: "back"), for: .normal)
        self.view.addSubview(backBtn)
        backBtn.addTarget(self, action: #selector(goback), for: .touchUpInside)
        backBtn.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(15)
        }
    }
    @objc func goback(){
        self.dismiss(animated: true, completion: nil)
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

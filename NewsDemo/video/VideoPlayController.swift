//
//  VideoPlayController.swift
//  NewsDemo
//
//  Created by zhanglin on 2018/4/13.
//  Copyright © 2018年 zhanglin. All rights reserved.
//

import UIKit
import Alamofire
import ZFPlayer
class VideoPlayController:BaseViewController,UITableViewDelegate,UITableViewDataSource,ZFPlayerDelegate{
    var tableView:UITableView!
    var videoView:UIView!
    var backgroundView:UIImageView!
    let bgUrl = "http://img.kaiyanapp.com/f31b4170c1b1a9c295b1cd74f3b56b72.jpeg?imageMogr2/quality/60/format/jpg/thumbnail/720x1280"
    var videoId:Int = -1
    var itemData = VideoItem()
    var videoList = [VideoItem]()
    var playView:ZFPlayerView!
    let playerController = ZFPlayerControlView()
    let playerMode = ZFPlayerModel()
    var headerView:VideoAuthorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        self.videoList.append(self.itemData)
    }
    override func viewDidAppear(_ animated: Bool) {
        loadVideoDetail()
        initPlayer()
    }
    func zf_playerBackAction() {
        self.dismiss(animated: true, completion: nil)
    }
    func initPlayer(){
        self.playView = ZFPlayerView()
        videoView.addSubview(playView)
        playView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalToSuperview()
        }
        playerMode.fatherView = videoView
        playView.playerControlView(playerController, playerModel: playerMode)
        playView.delegate = self
        startPlay()
        playView.autoPlayTheVideo()
    }
    private func startPlay(){
        playerMode.videoURL = URL(string:(itemData.data?.playInfo![0].url)!)
        playerMode.title = itemData.data?.title
        playView.reset(toPlayNewVideo: playerMode)
        playerController.zf_playerShowControlView()
    }
    
    private func setUp(){
        backgroundView = UIImageView()
        self.view.addSubview(backgroundView)
        videoView = UIView()
        videoView.backgroundColor = UIColor.black
        self.view.addSubview(videoView)
        headerView = VideoAuthorView()
        self.view.addSubview(headerView)
        tableView = UITableView()
        tableView.backgroundColor = UIColor.clear
        tableView.delegate  = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        backgroundView.sd_setImage(with: URL(string: bgUrl), completed: nil)
        tableView.register(VideoSmallCardCell.classForCoder(), forCellReuseIdentifier: "VideoBeanForClient")
        tableView.register(VideoTextCardCell.classForCoder(), forCellReuseIdentifier: "TextCard")
        tableView.register(VideoInfoCardCell.classForCoder(), forCellReuseIdentifier: "first")
        headerView.initData(author: (self.itemData.data?.author)!,url: (itemData.data?.playInfo![0].url)!)
        makeConstriants()
    }
    private func makeConstriants(){
        backgroundView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(self.view.frame.width*9/16)
        }
        videoView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(self.view.frame.width*9/16)
        }
        headerView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(videoView.snp.bottom)
            make.height.equalTo(70)
        }
        tableView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(headerView.snp.bottom)
        }
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = videoList[indexPath.row].data
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "first") as! VideoInfoCardCell
            cell.titleLable.text = data?.title
            cell.descLabel.text = data?.description
            cell.tagLabel.text = data?.tags?.count == 0 ? "#生活馆/\(formatSecondDuration(duration:(data?.duration)!))" : "#\(data?.tags![0].name ?? "生活馆")/\(formatSecondDuration(duration:(data?.duration)!))"
            cell.commentCountLabel.text = "\(data?.consumption?.replyCount ?? 0)"
            cell.heartCountLabel.text = "\(data?.consumption?.collectionCount ?? 0)"
            cell.shareCountLabel.text = "\(data?.consumption?.shareCount ?? 0)"
            cell.backgroundColor = UIColor.clear
            return cell
        }else if data?.dataType == "TextCard"{
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextCard") as! VideoTextCardCell
            cell.label.text = data?.text
            cell.arrow.image = UIImage(named: "arrow_right")
            cell.backgroundColor = UIColor.clear
            return cell
        }else{
            let smallCardCell = tableView.dequeueReusableCell(withIdentifier: "VideoBeanForClient") as! VideoSmallCardCell
            smallCardCell.bgImage.sd_setImage(with: URL(string: (data?.cover?.detail)!), completed: nil)
            smallCardCell.titleLabel.text = data?.title
            smallCardCell.tagLabel.text = "#" + (data?.category)! + "/\(formatSecondDuration(duration: (data?.duration)!))"
            smallCardCell.backgroundColor = UIColor.clear
            return smallCardCell
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row != 0 && videoList[indexPath.row].data?.dataType == "VideoBeanForClient"{
            videoId = (videoList[indexPath.row].data?.id)!
            itemData = videoList[indexPath.row]
            headerView.initData(author: (self.itemData.data?.author)!,url: (itemData.data?.playInfo![0].url)!)
            videoList.removeAll()
            videoList.append(itemData)
            loadVideoDetail()
            startPlay()
        }
    }
    private func loadVideoDetail(){
        showLoading()
        let url = "http://baobab.kaiyanapp.com/api/v4/video/related?id=\(videoId)"
        request(url).responseJSON { (response) in
            self.hideLoading()
            if response.error == nil{
                do{
                    let videoDetail = try self.decoder.decode(Issue.self, from: response.data!)
                    self.videoList.append(contentsOf: videoDetail.itemList!)
                    self.tableView.reloadData()
                }catch{
                    print(error)
                }
            }else{
                print(response.error!)
            }
        }
    }
}

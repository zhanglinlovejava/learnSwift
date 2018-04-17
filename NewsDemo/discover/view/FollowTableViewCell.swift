//
//  FollowTableViewCell.swift
//  NewsDemo
//
//  Created by zhanglin on 2018/4/11.
//  Copyright © 2018年 zhanglin. All rights reserved.
//

import UIKit
class FollowTableViewCell: UITableViewCell,UICollectionViewDataSource,UICollectionViewDelegate{
    let avatar = UIImageView()
    let title = UILabel()
    let desc = UILabel()
    let followBtn = UIButton()
    var collectionView:UICollectionView!
    var itemList:[VideoItem] = [VideoItem]()
    var fatherController:UIViewController?
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        self.contentView.addSubview(avatar)
        self.contentView.addSubview(title)
        self.contentView.addSubview(desc)
        self.contentView.addSubview(followBtn)
        self.contentView.addSubview(collectionView)
        makeConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setUI(){
        followBtn.setTitle("+ 关注", for: .normal)
        followBtn.setTitleColor(UIColor.black, for: .normal)
        followBtn.layer.borderColor = UIColor.black.cgColor
        followBtn.layer.borderWidth = 1
        followBtn.clipsToBounds = true
        followBtn.layer.cornerRadius = 5
        title.textColor = UIColor.black
        desc.textColor = UIColor.gray
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 50, height:280)
        layout.minimumLineSpacing = 0  //上下间隔
        layout.minimumInteritemSpacing = 0 //左右间隔
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.register(HorizontalCell.classForCoder(), forCellWithReuseIdentifier: "collection")
    }
    fileprivate func makeConstraints(){
        avatar.snp.makeConstraints { (make) in
            make.height.width.equalTo(65)
            make.left.top.equalToSuperview()
        }
        title.snp.makeConstraints { (make) in
            make.left.equalTo(avatar.snp.right).offset(10)
            make.top.equalTo(avatar).offset(10)
        }
        followBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-20)
            make.width.equalTo(80)
            make.centerY.equalTo(avatar)
        }
        desc.snp.makeConstraints { (make) in
            make.left.equalTo(title)
            make.top.equalTo(title.snp.bottom).offset(5)
            make.right.equalTo(followBtn.snp.left).offset(-10)
        }
        collectionView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(avatar.snp.bottom).offset(10)
            make.bottom.equalToSuperview()
        }
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let videoVC = VideoPlayController()
        videoVC.videoId = (itemList[indexPath.row].data?.id)!
        videoVC.itemData = itemList[indexPath.row]
        fatherController?.present(videoVC, animated: true, completion: nil)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collection", for: indexPath) as! HorizontalCell
        let item = itemList[indexPath.row].data
        let url = URL(string:(item?.cover?.feed)!)
        cell.horImage.sd_setImage(with: url, completed: nil)
        let durString = formatSecondDuration(duration: (item?.duration)!)
        cell.horTag.text = (item?.tags?.count)! == 0 ? "生活馆/\(durString)" : (item?.tags![0].name)! + "/\(durString)"
        cell.horTitle.text = item?.title ?? "默认title"
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemList.count
    }
    func refreshData( itemList:[VideoItem]){
        self.itemList = itemList
        collectionView.reloadData()
    }
}

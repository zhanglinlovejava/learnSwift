//
//  NewsDetailViewController.swift
//  NewsDemo
//
//  Created by zhanglin on 2018/4/10.
//  Copyright © 2018年 zhanglin. All rights reserved.
//

import UIKit
import Alamofire
import NVActivityIndicatorView
class NewsDetailViewController: BaseViewController ,UIWebViewDelegate{
    var newsId = 0
    var webView:UIWebView = UIWebView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "加载中..."
        addRightItem("刷新")
        setUp()
        getDetailData()
    }
    override func onRightClick() {
        showLoading()
        webView.reload()
    }
    fileprivate func setUp(){
        self.view.addSubview(webView)
        webView.delegate  = self
        webView.scalesPageToFit = true
        webView.allowsLinkPreview = true
        webView.snp.makeConstraints { (make) in
            make.size.equalTo(self.view.frame.size)
        }
    }
    fileprivate func getDetailData(){
        showLoading()
        let url = "http://news-at.zhihu.com/api/4/news/\(newsId)"
        request(url).responseData(completionHandler: { (data) in
            if data.error == nil{
                if let newsDetail = try? self.decoder.decode(NewsDetail.self, from: data.data!){
                    let url = newsDetail.share_url
                    let request = URLRequest(url: URL(string: url!)!)
                    self.webView.loadRequest(request)
                    self.title  = newsDetail.title
                }
            }else{
                print("请求出错")
            }
        })
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
        hideLoading()
    }
}

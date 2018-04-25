//
//  ZHNewsDetailViewController.swift
//  ZhihuDaily-Swift
//
//  Created by mzy on 16/5/31.
//  Copyright © 2016年 Jcdroid. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import Kingfisher

class ZHNewsDetailViewController: UIViewController, UIScrollViewDelegate {
    
    let webView: UIWebView = {
        let webView = UIWebView()
        //webView.backgroundColor = UIColor.clear
        webView.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal
        return webView
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        //imageView.image = UIImage.imageWithColor(UIColor.red)
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        return imageView
    }()
    
    let imageHeight: CGFloat = JCCGUtilities.CGFloatFromPixel(200)
    
    var news: ZHNews
    
    
    init(news: ZHNews) {
        self.news = news
        super.init(nibName: nil, bundle: nil)
        self.title = news.title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false // 解决UIScrollView属性contentOffset.y初始为-20的问题，设置后初始值为0
        
        self.webView.scrollView.delegate = self;
        self.view.addSubview(self.webView)
        self.webView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        self.view.addSubview(self.imageView)
        self.imageView.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(self.view)
            make.height.equalTo(imageHeight)
        }
        
        loadNewData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.barStyle = UIBarStyle.default
    }

    // MARK: - UIScrollViewDelegate
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let point = scrollView.contentOffset
        let curY = point.y
        
        if curY >= 0 {// 上滑下滚并且大于0，图片收缩滚动
            self.imageView.snp.updateConstraints { (make) in
                make.top.equalTo(self.view).offset(-curY/2)
                make.left.right.equalTo(self.view)
            }
        } else if curY >= -imageHeight {// 图片正常滚动
            self.imageView.snp.updateConstraints { (make) in
                make.top.equalTo(self.view).offset(-curY)
                make.left.right.equalTo(self.view)
            }
        } else {// 图片缩放
            self.imageView.snp.updateConstraints { (make) in
                make.left.equalTo(self.view).offset(curY + imageHeight)
                make.right.equalTo(self.view).offset(-(curY + imageHeight))
            }
        }
        
    }
    
    // MARK: - private method
    
    func loadNewData() {
        let newsId = self.news.id
        let url = String.init(format: ZHConstants.ZHIHU_NEWS_DETAILS, newsId!)
        
        Alamofire.request(url).responseObject { (response: DataResponse<ZHNewsDetail>) in
            let newsDetail = response.result.value
            
            let image = newsDetail?.image
            self.imageView.kf.setImage(with: URL(string: image!)!)
            
            let cssArray = newsDetail?.css
            let css = cssArray![0]
            let head = "<head><link rel=\"stylesheet\" type=\"text/css\" href=\"\(css)\"></head>"
            let body = newsDetail?.body
            let html = "\(head)\(body!)"
            self.webView.loadHTMLString(html, baseURL: nil)
        }
    }

}

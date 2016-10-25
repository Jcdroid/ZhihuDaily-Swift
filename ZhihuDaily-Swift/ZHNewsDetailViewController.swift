//
//  ZHNewsDetailViewController.swift
//  ZhihuDaily-Swift
//
//  Created by mzy on 16/5/31.
//  Copyright © 2016年 Jcdroid. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

class ZHNewsDetailViewController: UIViewController, UIScrollViewDelegate {
    
    let imageView = UIImageView()
    
    let webView = UIWebView()
    
    let imageHeight: CGFloat = JCCGUtilities.CGFloatFromPixel(200)
    
    
    var newsInfo: NSDictionary
    
    init(newsInfo: NSDictionary) {
        self.newsInfo = newsInfo
        super.init(nibName: nil, bundle: nil)
        self.title = newsInfo["title"] as? String
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false // 解决UIScrollView属性contentOffset.y初始为-20的问题，设置后初始值为0
        
        //self.webView.backgroundColor = UIColor.clear
        self.webView.scrollView.delegate = self;
        self.view.addSubview(self.webView)
        self.webView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        //self.imageView.image = UIImage.imageWithColor(UIColor.red)
        self.imageView.contentMode = UIViewContentMode.scaleAspectFill
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
        let newsId = self.newsInfo["id"] as! NSNumber
        let url = String.init(format: ZHConstants.ZHIHU_NEWS_DETAILS, newsId)
        Alamofire.request(url).responseJSON { response in
            let JSON = response.result.value as! NSDictionary
            
            let image = JSON.object(forKey: "image") as! String
            let resource = ImageResource.init(downloadURL: URL.init(string: image)!)
            self.imageView.kf.setImage(with: resource)
            
            let cssArray = JSON.object(forKey: "css") as! NSArray
            let css = cssArray[0] as! String
            let head = "<head><link rel=\"stylesheet\" type=\"text/css\" href=\"\(css)\"></head>"
            let body = JSON.object(forKey: "body") as! String
            let html = "\(head)\(body)"
            self.webView.loadHTMLString(html, baseURL: nil)
        }
    }

}

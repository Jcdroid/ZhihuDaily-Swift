//
//  ZHNewsDetailViewController.swift
//  ZhihuDaily-Swift
//
//  Created by mzy on 16/5/31.
//  Copyright © 2016年 Jcdroid. All rights reserved.
//

import UIKit
import Alamofire

class ZHNewsDetailViewController: UIViewController {
    
    let imageView = UIImageView()
    let webView = UIWebView()
    
    let imageHeight: CGFloat = 200
    
    
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
        
        self.view.addSubview(self.webView)
        self.webView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        print("point height = ", imageHeight)
        self.imageView.frame = CGRect(x: 0, y: 0, width: 640, height: imageHeight*2)
        self.imageView.image = UIImage.imageWithColor(UIColor.red)
        self.imageView.contentMode = UIViewContentMode.scaleAspectFill
        self.webView.scrollView.addParallax(with: imageView, andHeight: imageHeight);
        
        loadNewData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - private method
    func loadNewData() {
        let newsId = self.newsInfo["id"] as! NSNumber
        let url = String.init(format: ZHConstants.ZHIHU_NEWS_DETAILS, newsId)
        Alamofire.request(url).responseJSON { response in
            let JSON = response.result.value as! NSDictionary
            let cssArray = JSON.object(forKey: "css") as! NSArray
            let css = cssArray[0] as! String
            let head = "<head><link rel=\"stylesheet\" type=\"text/css\" href=\"\(css)\"></head>"
            let body = JSON.object(forKey: "body") as! String
            let html = "\(head)\(body)"
            self.webView.loadHTMLString(html, baseURL: nil)
        }
    }

}

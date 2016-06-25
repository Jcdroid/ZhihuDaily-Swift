//
//  ZHStartViewController.swift
//  ZhihuDaily-Swift
//
//  Created by mac on 16/1/14.
//  Copyright © 2016年 Jcdroid. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire
import Kingfisher

private extension Selector {
    static let clickButton = #selector(ZHStartViewController.clickButton(_:))
}

class ZHStartViewController: UIViewController {
    
    /**
     *  代替Button addTarget中的action部分
     */
    private struct Action {
        static let clickButton = #selector(ZHStartViewController.clickButton(_:))
    }
    
    lazy var imageView = UIImageView()
    lazy var button = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadNewData()
        
        self.view.addSubview(imageView)
        imageView.snp_makeConstraints { (make) in
            make.edges.equalTo(self.view).inset(EdgeInsetsZero)
        }
        imageView.kf_setImageWithURL(NSURL(string: "https://pic2.zhimg.com/5578a7ef3511657cee1555be513a15d5.jpg")!)
        
        self.view.addSubview(button)
        button.setTitle("News List", forState: .Normal)
        // button.addTarget(self, action: #selector(self.clickButton(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        // button.addTarget(self, action: Action.clickButton, forControlEvents: .TouchUpInside)
        button.addTarget(self, action: .clickButton, forControlEvents: .TouchUpInside)
        button.snp_makeConstraints { (make) in
            make.center.equalTo(self.view)
            make.height.equalTo(44.0)
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(3 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) { () -> Void in
            UIView.animateWithDuration(1, animations: {
                self.view.alpha = 0.0
                }, completion: { (Bool) in
                    let delegate = UIApplication.sharedApplication().delegate as! ZHAppDelegate
                    delegate.window?.rootViewController = UINavigationController.init(rootViewController: ZHNewsListViewController())
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func clickButton(sender: UIButton!) {
        self.navigationController?.pushViewController(ZHNewsListViewController(), animated: true)
    }

    // MARK: - private method
    
    func loadNewData() {
        Alamofire.request(.GET, ZHConstants.ZHIHU_START_IMAGE).responseJSON { response in
            let imgUrl = response.result.value?.objectForKey("img") as! String;
            self.imageView.kf_setImageWithURL(NSURL(string: imgUrl)!)
        }
    }

}


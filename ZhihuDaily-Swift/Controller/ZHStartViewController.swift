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
import AlamofireObjectMapper
import Kingfisher

private extension Selector {
    static let clickButton = #selector(ZHStartViewController.clickButton(_:))
}

class ZHStartViewController: UIViewController {
    
    /**
     *  代替Button addTarget中的action部分
     */
    fileprivate struct Action {
        static let clickButton = #selector(ZHStartViewController.clickButton(_:))
    }
    
    lazy var imageView = UIImageView()
    lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("News List", for: UIControlState())
        // button.addTarget(self, action: #selector(self.clickButton(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        // button.addTarget(self, action: Action.clickButton, forControlEvents: .TouchUpInside)
        button.addTarget(self, action: .clickButton, for: .touchUpInside)
        button.isHidden = true
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadNewData()
        
        self.view.addSubview(imageView)
        self.view.addSubview(button)
        imageView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view).inset(UIEdgeInsets.zero)
        }
        button.snp.makeConstraints { (make) in
            make.center.equalTo(self.view)
            make.height.equalTo(44.0)
        }
        
        imageView.kf.setImage(with: URL(string: "https://pic2.zhimg.com/5578a7ef3511657cee1555be513a15d5.jpg")!)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(3 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)) { () -> Void in
            UIView.animate(withDuration: 1, animations: {
                self.view.alpha = 0.0
                }, completion: { (Bool) in
                    let delegate = UIApplication.shared.delegate as! ZHAppDelegate
                    delegate.window?.rootViewController = UINavigationController.init(rootViewController: ZHNewsListViewController())
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func clickButton(_ sender: UIButton!) {
        self.navigationController?.pushViewController(ZHNewsListViewController(), animated: true)
    }
 
    // MARK: - private method
    
    func loadNewData() {
        let url = ZHConstants.ZHIHU_START_IMAGE
        Alamofire.request(url).responseObject { (response: DataResponse<ZHStartImage>) in
            let startImage = response.result.value
            if let img = startImage?.image {
                let resource = ImageResource.init(downloadURL: URL.init(string: img)!)
                self.imageView.kf.setImage(with: resource)
            }
        }
    }

}


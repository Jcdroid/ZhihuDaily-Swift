//
//  ZHNewsListViewController.swift
//  ZhihuDaily-Swift
//
//  Created by mzy on 16/5/3.
//  Copyright © 2016年 Jcdroid. All rights reserved.
//

import UIKit
import Alamofire

class ZHNewsListViewController: UITableViewController {
    
    var dataSourceArray = NSMutableArray()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "知乎日报"

        self.clearsSelectionOnViewWillAppear = true

        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        self.tableView.register(ZHNewListCell.self, forCellReuseIdentifier: ZHConstants.kCellIdentifier)
        
        self.loadNewData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSourceArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ZHConstants.kCellIdentifier, for: indexPath) as UITableViewCell
        configureCell(cell, forRowAtIndexPath: indexPath)
        return cell
    }
    
    func configureCell(_ cell: UITableViewCell, forRowAtIndexPath: IndexPath) {
        let newListCell = cell as! ZHNewListCell
        newListCell.configNewInfo(self.dataSourceArray.object(at: (forRowAtIndexPath as NSIndexPath).row) as! NSDictionary)
    }
    
    //MARK: UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let newsInfo = self.dataSourceArray[(indexPath as NSIndexPath).row] as! NSDictionary
        
        self.navigationController?.pushViewController(ZHNewsDetailViewController.init(newsInfo: newsInfo), animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView.init()
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView.init()
    }
    
    // MARK: - private method
    func loadNewData() {
        let url = ZHConstants.ZHIHU_LASTEST_NEWS
        Alamofire.request(url).responseJSON { response in
            let JSON = response.result.value as! NSDictionary
            let stories = JSON.object(forKey: "stories")
            self.dataSourceArray = stories as! NSMutableArray
            self.tableView.reloadData()
        }
    }

}

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

        self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.tableView.registerClass(ZHNewListCell.self, forCellReuseIdentifier: ZHConstants.kCellIdentifier)
        
        self.loadNewData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: UITableViewDataSource
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSourceArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(ZHConstants.kCellIdentifier, forIndexPath: indexPath) as UITableViewCell
        configureCell(cell, forRowAtIndexPath: indexPath)
        return cell
    }
    
    func configureCell(cell: UITableViewCell, forRowAtIndexPath: NSIndexPath) {
        let newListCell = cell as! ZHNewListCell
        newListCell.configNewInfo(self.dataSourceArray.objectAtIndex(forRowAtIndexPath.row) as! NSDictionary)
    }
    
    //MARK: UITableViewDelegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let newsInfo = self.dataSourceArray[indexPath.row] as! NSDictionary
        
        self.navigationController?.pushViewController(ZHNewsDetailViewController.init(newsInfo: newsInfo), animated: true)
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView.init()
    }
    
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView.init()
    }
    
    // MARK: - private method
    func loadNewData() {
        Alamofire.request(.GET, ZHConstants.ZHIHU_LASTEST_NEWS).responseJSON { response in
            let stories = response.result.value?.objectForKey("stories")
            self.dataSourceArray = stories as! NSMutableArray
            self.tableView.reloadData()
        }
    }

}

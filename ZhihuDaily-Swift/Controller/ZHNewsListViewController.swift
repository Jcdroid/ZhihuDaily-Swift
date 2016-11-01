//
//  ZHNewsListViewController.swift
//  ZhihuDaily-Swift
//
//  Created by mzy on 16/5/3.
//  Copyright © 2016年 Jcdroid. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

class ZHNewsListViewController: UITableViewController {
    
    var dataSourceArray: [ZHNews]?

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
        if let dataSourceArray = self.dataSourceArray {
            return dataSourceArray.count
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ZHConstants.kCellIdentifier, for: indexPath) as UITableViewCell
        configureCell(cell, forRowAtIndexPath: indexPath)
        return cell
    }
    
    func configureCell(_ cell: UITableViewCell, forRowAtIndexPath: IndexPath) {
        let newListCell = cell as! ZHNewListCell
        
        let news = self.dataSourceArray?[forRowAtIndexPath.row]
        newListCell.configNews(news!)
    }
    
    //MARK: UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let news = self.dataSourceArray?[indexPath.row]
        
        self.navigationController?.pushViewController(ZHNewsDetailViewController.init(news: news!), animated: true)
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
        Alamofire.request(url).responseObject { (response: DataResponse<ZHNewsList>) in
            let newsList = response.result.value
            
            if let stories = newsList?.stories {
                self.dataSourceArray = stories
                self.tableView.reloadData()
            }
        }
    }

}

//
//  ZHNewListCell.swift
//  ZhihuDaily-Swift
//
//  Created by mzy on 16/5/30.
//  Copyright © 2016年 Jcdroid. All rights reserved.
//

import UIKit
import Kingfisher
import SnapKit

class ZHNewListCell: UITableViewCell {
    
    var imgView = UIImageView()
    var titleLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(self.imgView)
        self.contentView.addSubview(self.titleLabel)
        
        self.titleLabel.numberOfLines = 0
        
        self.imgView.snp_makeConstraints(closure: { (make) in
            make.left.top.equalTo(self.contentView).offset(ZHConstants.kPadding8)
            make.bottom.equalTo(self.contentView).offset(-ZHConstants.kPadding8)
            make.width.equalTo(self.imgView.snp_height)
        })
        self.titleLabel.snp_makeConstraints(closure: { (make) in
            make.top.equalTo(self.imgView.snp_top)
            make.left.equalTo(self.imgView.snp_right).offset(ZHConstants.kPadding8)
            make.right.equalTo(self.contentView).offset(-ZHConstants.kPadding8)
            make.bottom.equalTo(self.contentView).priorityLow()
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - public method
    internal func configNewInfo(newInfo: NSDictionary) {
        let images: NSArray = newInfo["images"] as! NSArray
        self.imgView.kf_setImageWithURL(NSURL(string: images[0] as! String)!)
        self.titleLabel.text = newInfo.objectForKey("title") as? String
    }

}

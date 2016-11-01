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
    
    var imgView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(self.imgView)
        self.contentView.addSubview(self.titleLabel)
        
        self.imgView.snp.makeConstraints({ (make) in
            make.left.top.equalTo(self.contentView).offset(ZHConstants.kPadding8)
            make.bottom.equalTo(self.contentView).offset(-ZHConstants.kPadding8)
            make.width.equalTo(self.imgView.snp.height)
        })
        self.titleLabel.snp.makeConstraints({ (make) in
            make.top.equalTo(self.imgView.snp.top)
            make.left.equalTo(self.imgView.snp.right).offset(ZHConstants.kPadding8)
            make.right.equalTo(self.contentView).offset(-ZHConstants.kPadding8)
            make.bottom.equalTo(self.contentView).priority(250)
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - public method
    internal func configNews(_ news: ZHNews) {
        let images = news.images
        let image = images?[0] as! String
        self.imgView.kf.setImage(with: URL(string: image)!)
        self.titleLabel.text = news.title
    }

}

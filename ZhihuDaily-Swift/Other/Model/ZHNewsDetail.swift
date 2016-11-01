//
//  ZHNewsDetail.swift
//  ZhihuDaily-Swift
//
//  Created by mzy on 16/10/31.
//  Copyright © 2016年 Jcdroid. All rights reserved.
//

import ObjectMapper

class ZHNewsDetail: Mappable {
    var image: String?
    var css: NSArray?
    var body: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        image <- map["image"]
        css <- map["css"]
        body <- map["body"]
    }

}

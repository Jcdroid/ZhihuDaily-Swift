//
//  ZHStartImage.swift
//  ZhihuDaily-Swift
//
//  Created by mzy on 16/10/31.
//  Copyright © 2016年 Jcdroid. All rights reserved.
//

import ObjectMapper

class ZHStartImage: Mappable {
    var image: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        image <- map["img"]
    }
}

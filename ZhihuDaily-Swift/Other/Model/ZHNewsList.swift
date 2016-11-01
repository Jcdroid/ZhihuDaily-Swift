//
//  ZHNewsList.swift
//  ZhihuDaily-Swift
//
//  Created by mzy on 16/10/31.
//  Copyright © 2016年 Jcdroid. All rights reserved.
//

import ObjectMapper

class ZHNewsList: Mappable {
    var stories: [ZHNews]?
    

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        stories <- map["stories"]
    }
    
}

class ZHNews: Mappable {
    var id: NSNumber?
    var title: String?
    var images: NSArray?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        images <- map["images"]
    }
}

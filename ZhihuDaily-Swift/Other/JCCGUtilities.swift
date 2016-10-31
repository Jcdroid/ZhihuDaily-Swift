//
//  JCCGUtilities.swift
//  ZhihuDaily-Swift
//
//  Created by mzy on 16/6/2.
//  Copyright © 2016年 Jcdroid. All rights reserved.
//

import UIKit

class JCCGUtilities: NSObject {
    
    
    /**
     Convert point to pixel.
     
     - parameter value: point
     
     - returns: pixel
     */
    class func CGFloatToPixel(_ value: CGFloat) -> CGFloat {
        return value * UIScreen.screenScale()
    }
    
    /**
     Convert pixel to point.
     
     - parameter value: pixel
     
     - returns: point
     */
    class func CGFloatFromPixel(_ value: CGFloat) -> CGFloat {
        return value / UIScreen.screenScale()
    }
    
}

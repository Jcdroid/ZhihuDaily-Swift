//
//  UIImageExtensions.swift
//  ZhihuDaily-Swift
//
//  Created by mzy on 16/6/2.
//  Copyright © 2016年 Jcdroid. All rights reserved.
//

import UIKit

extension UIImage {

    public class func imageWithColor(color: UIColor) -> UIImage? {
        return self.imageWithColor(color, size: CGSizeMake(1, 1))
    }
    
    public class func imageWithColor(color: UIColor, size: CGSize) -> UIImage? {
        if (size.width <= 0 || size.height <= 0) {
            return nil
        }
        let rect: CGRect = CGRectMake(0, 0, size.width, size.height)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        let context: CGContextRef = UIGraphicsGetCurrentContext()!
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillRect(context, rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
}

//
//  UIImageExtensions.swift
//  ZhihuDaily-Swift
//
//  Created by mzy on 16/6/2.
//  Copyright © 2016年 Jcdroid. All rights reserved.
//

import UIKit

extension UIImage {

    public class func imageWithColor(_ color: UIColor) -> UIImage? {
        return self.imageWithColor(color, size: CGSize(width: 1, height: 1))
    }
    
    public class func imageWithColor(_ color: UIColor, size: CGSize) -> UIImage? {
        if (size.width <= 0 || size.height <= 0) {
            return nil
        }
        let rect: CGRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        let context: CGContext = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor)
        context.fill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
}

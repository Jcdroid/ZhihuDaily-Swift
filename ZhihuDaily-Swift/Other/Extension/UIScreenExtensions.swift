//
//  UIScreenExtensions.swift
//  ZhihuDaily-Swift
//
//  Created by mzy on 16/6/2.
//  Copyright © 2016年 Jcdroid. All rights reserved.
//

import UIKit

extension UIScreen {
    
    /**
     Get screen scale
     
     - returns: scale
     */
    public class func screenScale() -> CGFloat {
        return UIScreen.main.scale;
    }
    
    /// Get screen width
    ///
    /// - returns: width
    public class func screenWidth() -> CGFloat {
        return UIScreen.main.bounds.size.width
    }
    
    /// Get screen height
    ///
    /// - returns: height
    public class func screenHeight() -> CGFloat {
        return UIScreen.main.bounds.size.height
    }
    
}

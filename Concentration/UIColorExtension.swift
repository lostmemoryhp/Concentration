//
//  UIColorExtension.swift
//  Concentration
//
//  Created by 廖海平 on 16/6/23.
//  Copyright © 2016年 廖海平. All rights reserved.
//

import Foundation
import UIKit

extension UIColor{
    class func colorComponents(components:(CGFloat,CGFloat,CGFloat))->UIColor{
        return UIColor(red: components.0/255.0, green: components.1/255.0, blue: components.2/255.0, alpha: 1.0)
    }
    class func greenSea()->UIColor {
        return UIColor.colorComponents((22,160,133))
    }
    class func emerald()->UIColor{
        return UIColor.colorComponents((46,204,113))
    }
    class func sunflower()->UIColor {
        return UIColor.colorComponents((241,196,15))
    }
    class  func alizarin()->UIColor {
        return UIColor.colorComponents((231,76,60))
    }
}
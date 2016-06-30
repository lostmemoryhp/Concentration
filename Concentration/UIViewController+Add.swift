//
//  UIViewController+Add.swift
//  Concentration
//
//  Created by 廖海平 on 16/7/1.
//  Copyright © 2016年 廖海平. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    func execAfter(delay: Double,  block: ()->Void){
        dispatch_after(dispatch_time(
            DISPATCH_TIME_NOW,
            Int64(delay * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), block)
    }
}
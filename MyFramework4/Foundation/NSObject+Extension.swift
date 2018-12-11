//
//  NSObject+Extension.swift
//  CRM4iOS
//
//  Created by lee on 2017/9/29.
//  Copyright © 2017年 manqian. All rights reserved.
//

import Foundation

extension NSObject {
    public static func getVCByClassString(className: String) -> UIViewController? {
        
        guard let nameSpage = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String else {
            print("没有命名空间")
            return nil
        }
        
        guard let childVcClass = NSClassFromString(nameSpage + "." + className) else {
            print("没有获取到对应的class")
            return nil
        }
        
        guard let childVcType = childVcClass as? UIViewController.Type else {
            print("没有得到的类型")
            return nil
        }
        
        return childVcType.init()
    }
}

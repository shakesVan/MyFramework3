//
//  String+Size.swift
//  ManqianBao
//
//  Created by fanyao on 2017/6/6.
//  Copyright © 2017年 fanyao. All rights reserved.
//
//

import UIKit
import Foundation

extension NSString {
    
    /// 返回文本高度
    ///
    /// - Parameters:
    ///   - width: 文本占宽
    ///   - font: 文本字体
    /// - Returns: 文本高度
    fileprivate func height(with width:CGFloat, font:UIFont) -> CGFloat {
        let constraintRect = CGSize(width:width,height:.greatestFiniteMagnitude)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return boundingBox.height
    }
    
    /// 返回文本宽度
    ///
    /// - Parameters:
    ///   - height: 文本占高
    ///   - font: 文本字体
    /// - Returns: 文本宽度
    fileprivate func width(with height: CGFloat ,font:UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let attributes = [NSAttributedString.Key.font: font]
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        
        let boundingBox = boundingRect(with: constraintRect, options: option, attributes: attributes, context: nil)
        return boundingBox.width
    }
}

extension String {
    /// 返回文本高度
    ///
    /// - Parameters:
    ///   - width: 文本占宽
    ///   - font: 文本字体
    /// - Returns: 文本高度
    public func height(with width:CGFloat, font:UIFont) -> CGFloat {
        let calString = self as NSString
        return calString.height(with: width, font: font)
    }
    /// 返回文本宽度
    ///
    /// - Parameters:
    ///   - height: 文本占高
    ///   - font: 文本字体
    /// - Returns: 文本宽度
    public func width(with height: CGFloat ,font:UIFont) -> CGFloat {
        let calString = self as NSString
        return calString.width(with: height, font: font)
    }
}

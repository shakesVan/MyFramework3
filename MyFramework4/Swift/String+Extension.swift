//
//  String+Extension.swift
//  ManqianBao
//
//  Created by fanyao on 2017/6/6.
//  Copyright © 2017年 fanyao. All rights reserved.
//

import UIKit

// MARK: - count
extension String {
    /// 字符串长度
    public var length: Int {
        return self.count
    }
    
    /// 按UTF16标准的字符串长度
    public var utf16Length:Int {
        return self.utf16.count
    }
    
    /// 返回Index类型
    ///
    public func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
    
    public static func className(_ aClass: AnyClass) -> String {
        return NSStringFromClass(aClass).components(separatedBy: ".").last!
    }
}

// MARK: - substring
extension String {
    //http://stackoverflow.com/questions/39677330/how-does-string-substring-work-in-swift-3
    
    /// 裁剪字符串from
    ///
    /// - Parameter from: 从哪里开始
    public func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return substring(from: fromIndex)
    }
    
    /// 裁剪字符串to
    ///
    /// - Parameter to: 到哪里结束
    public func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return substring(to: toIndex)
    }
    
    /// 裁剪字符串range
    ///
    /// - Parameter r: 范围
    public func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return substring(with: startIndex..<endIndex)
    }
}

extension String {
    
    /// 随机字符串，包含大小写字母、数字
    ///
    /// - Parameter length: 长度应小于62
    public static func randomCharsNums(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return random(length: length, letters: letters)
    }
    
    /// 随机字符串，只包含大小写字母
    ///
    /// - Parameter length: 长度应小于52
    public static func randomChars(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        return random(length: length, letters: letters)
    }
    
    /// 随机字符串，只包含数字
    ///
    /// - Parameter length: 长度应小于10
    public static func randomNums(length: Int) -> String {
        let letters = "0123456789"
        return random(length: length, letters: letters)
    }
    
    
    /// 随机字符串
    ///
    /// - Parameters:
    ///   - length: 生成的字符串长度
    ///   - letters: 用语生成随机字符串的字符串数据集
    public static func random(length: Int,letters:String) -> String {
        let len = UInt32(letters.length)
        var randomString = ""
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            let nextCharIndex = letters.index(letters.startIndex, offsetBy: Int(rand))
            let nextChar = String(letters[nextCharIndex])
            randomString += nextChar
        }
        
        return randomString
    }
    
    
    /// 根据传入的规则限定字符串的内容
    ///
    /// - Parameters:
    ///   - regexStr: 筛选的规则字符串
    /// - Returns: 筛选后的字符串
    public func filterCharactor(regexStr: String) -> String {
        let regex: NSRegularExpression = try! NSRegularExpression.init(pattern: regexStr, options: [.caseInsensitive])
        let result = regex.stringByReplacingMatches(in: self, options: .reportCompletion, range: NSMakeRange(0, self.length), withTemplate: "")
        return result
    }
}

extension String{

    public func size(font: UIFont, size: CGSize) -> CGSize {
        let attribute = [ NSAttributedString.Key.font: font ]
        let conten = NSString(string: self)
        return conten.boundingRect(with: CGSize(width: size.width, height: size.height), options: .usesLineFragmentOrigin, attributes: attribute, context: nil).size
    }
}

extension String{
    // 判断是否是纯数字
    public func isPurnInt() -> Bool {
        let scan: Scanner = Scanner(string: self)
        
        var val:Int = 0
        
        return scan.scanInt(&val) && scan.isAtEnd
    }
    
    
    /// 设置只能输入数字
    ///
    public static func checkIsPurnInt(textFiledText: inout String?) -> Bool{
        //只能输入数字
        if let text = textFiledText, !text.isEmpty {
            let lastStr = text.substring(from: text.length - 1)
            if  !lastStr.isPurnInt() {
                textFiledText = text.substring(to: text.length - 1)
                return true
            }
        }
        return false
    }
}

extension String {
    
    /**
     * 数字千分位插入逗号
     */
    func decimalFormatter() -> String {
        let number: NumberFormatter = NumberFormatter.init()
        let result = number.number(from: self)
        if result == nil {
            return self
        } else {
            number.formatterBehavior = .behavior10_4
            number.numberStyle = .decimal
            number.locale = NSLocale.current
            //设置最小小数点后的位数
            number.minimumFractionDigits = 2
            //设置最大小数点后的位数
            number.maximumFractionDigits = 2
            let absresult: Double = (result?.doubleValue)!
            return number.string(from: NSNumber.init(value: absresult))!
        }
    }
    
    func decimalFormatterWithoutPoint() -> String {
        let number: NumberFormatter = NumberFormatter.init()
        let result = number.number(from: self)
        if result == nil {
            return self
        } else {
            number.formatterBehavior = .behavior10_4
            number.numberStyle = .decimal
            number.locale = NSLocale.current
            let absresult: Double = (result?.doubleValue)!
            return number.string(from: NSNumber.init(value: absresult))!
        }
    }
}

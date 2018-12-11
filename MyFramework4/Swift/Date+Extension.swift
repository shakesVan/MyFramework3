//
//  Date+Extension.swift
//  CRM4iOS
//
//  Created by fanyao on 2017/10/18.
//  Copyright © 2017年 manqian. All rights reserved.
//

import Foundation

extension Date {
    
    /// 获取时间段字符串
    ///
    /// - Parameters:
    ///   - startTime: 开始时间
    ///   - endTime: 结束时间
    ///   - dateFormat = "yyyy-MM-dd HH:mm:ss"
    public static func getNewTimeInterval(start: String, end: String) -> String {
        let dateFormat = "yyyy-MM-dd HH:mm:ss"
        return Date.getNewTimeInterval(start: start, end: end, dateFormat: dateFormat)
    }
    
    /// 获取时间段字符串
    ///
    /// - Parameters:
    ///   - startTime: 开始时间
    ///   - endTime: 结束时间
    ///   - dateFormat = "yyyy-MM-dd HH:mm:ss"
    public static func getNewTimeInterval(start: String, end: String, dateFormat: String) -> String {
        let dp = DateFormatterTool.shareInstance
        dp.dateFormat = dateFormat
        if let startTime: Date = dp.date(from: start),
            let endTime: Date = dp.date(from: end){
            return Date.getNewTimeInterval(start: startTime, end: endTime)
        }
        return ""
    }

    /// 获取新的时间段字符串
    ///
    /// - Parameters:
    ///   - start: 开始时间
    ///   - end: 结束时间
    public static func getNewTimeInterval(start: Date, end: Date) -> String{
        let calender = Calendar.current
        
        let components0 = calender.dateComponents([.year, .month, .day], from: Date())
        let components1 = calender.dateComponents([.year, .month, .day], from: start)
        let components2 = calender.dateComponents([.year, .month, .day], from: end)
        let dp = DateFormatterTool.shareInstance
        
        if components1.year != components0.year || components1.year != components2.year {
            dp.dateFormat = "yyyy-MM-dd HH:mm"
            
        }else if components1.month == components0.month,
            components1.day == components0.day{
            dp.dateFormat = "HH:mm"
        }else {
            dp.dateFormat = "MM-dd HH:mm"
        }
        
        let beginTime = dp.string(from: start)
        let time = beginTime + " — " + dp.string(from: end)
        return time
    }
    
    /// 当前时间是否大于 指定时间
    ///
    /// - Parameters:
    ///   - time: 指定时间
    ///   - dateFormat: 时间格式
    public static func isOutTime(time: String, dateFormat: String = "yyyy-MM-dd HH:mm:ss") -> Bool {
        let dp = DateFormatterTool.shareInstance
        dp.dateFormat = dateFormat
        guard let endDate = dp.date(from: time) else {
            return false
        }
        let date = Date()
        return date > endDate
    }
    
    
    /// 转换时间字符串
    ///
    /// - Parameters:
    ///   - time: 转换前
    ///   - newDateFormat: 新的格式
    ///   - oldDateFormat: 久的格式
    /// - Returns: 新的字符串
    public static func transform(time: String,
                          newDateFormat: String,
                          oldDateFormat: String = "yyyy-MM-dd HH:mm:ss") -> String {
        let dp = DateFormatterTool.shareInstance
        dp.dateFormat = oldDateFormat
        guard let date = dp.date(from: time) else{
            return time
        }
        dp.dateFormat = newDateFormat
        
        return dp.string(from: date)
    }
    
}

extension Date {
    
    /// 获取默认时间格式的时间字符串
    func getDefaultDateFormatTime() -> String {
        return getTime(dateFormat: "yyyy-MM-dd HH:mm:ss")
    }
    
    /// 获取时间格式为dateFormat 的时间字符串
    func getTime(dateFormat: String) -> String {
        let df = DateFormatterTool.shareInstance
        df.dateFormat = dateFormat
        return df.string(from: self)
    }
    
    /// 获取默认时间格式 的 时间
    /// - Parameter time: 默认时间格式时间字符串
    public static func getDefaultDateFormatTime(time: String) -> Date {
        let df = DateFormatterTool.shareInstance
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return df.date(from: time) ?? Date()
    }
    
    
    /// 是否是明天之前
    func isBeginTomorrow() -> Bool {
        let tomorrow = Date(timeIntervalSinceNow: 24 * 3600)
        let start = Int(Date.transform(time: self.getDefaultDateFormatTime(),
                                       newDateFormat: "yyyyMMdd")) ?? 0
        let tomor = Int(Date.transform(time: tomorrow.getDefaultDateFormatTime(),
                                     newDateFormat: "yyyyMMdd")) ?? 0
        if start < tomor {
            return true
        }
        return false
    }
    
    public static func isBeginTomorrow(start: String) -> Bool {
        let dp = DateFormatterTool.shareInstance
        dp.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let date = dp.date(from: start) {
            return date.isBeginTomorrow()
        }
        return false
    }
    
    /// 获取半整的时间（30）
    public static func getHalfWholeDate() -> Date {
        let date = Date()
        let dp = DateFormatterTool.shareInstance
        dp.dateFormat = "mm"
        let mm = dp.string(from: date)
        dp.dateFormat = "ss"
        let ss = dp.string(from: date)
        let addss = Int(ss) ?? 0
        let addmm = 30 - (Int(mm) ?? 0) % 30
        let wholeDate = Date(timeIntervalSinceNow: TimeInterval(addmm * 60 - addss))
        
        dp.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let halfWholeDate = dp.date(from: dp.string(from: wholeDate))!
        return halfWholeDate
    }
}

struct DateFormatterTool {
    public static let shareInstance = DateFormatter()
    private init() {}
}



extension Date {
    
    /// 获取当前月份
    public static var nowMounth: String {
        let date = Date()
        let f = DateFormatter()
        f.dateFormat = "yyyy年MM月"
        let nowMounth = f.string(from: date)
        return nowMounth
    }
    
    public static var nowMounthMsg: String {
        let date = Date()
        let f = DateFormatter()
        f.dateFormat = "M月慢钱财富产品付息一览"
        let nowMounth = f.string(from: date)
        return nowMounth
    }
    
}

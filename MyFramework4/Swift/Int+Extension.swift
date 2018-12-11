//
//  Int+Extension.swift
//  FoundationExtension
//
//  Created by 范摇 on 2018/12/7.
//  Copyright © 2018 范摇. All rights reserved.
//

import Foundation

extension Int {
    public var timeString: String {
        let h = self / (60 * 60)
        let m = self / 60
        let s = self % 60
        let string = "\(h.hasTenString):\(m.hasTenString):\(s.hasTenString)"
        return string
    }
    
    private var hasTenString: String {
        if self < 10 {
            return "0\(self)"
        }
        return "\(self)"
    }
}

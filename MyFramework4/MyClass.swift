//
//  MyClass.swift
//  MyFramework4
//
//  Created by 范摇 on 2018/12/11.
//  Copyright © 2018 范摇. All rights reserved.
//

import Foundation
import SnapKit
import UIKit

public class MyClass {
    static public func sayHello() {
        let v1 = UIView()
        let v2 = UIView()
        v1.addSubview(v2)
        v2.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        print("MyClass sayHello")
    }
}

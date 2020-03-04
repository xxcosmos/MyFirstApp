//
//  IntExtension.swift
//  MyFirstApp
//
//  Created by 张啸宇 on 2020/3/4.
//  Copyright © 2020 xiaoyuu. All rights reserved.
//

import Foundation

extension Int {
    
    static func random(num: Int) -> Int {
        guard num >= 0 else {return num}
        return Int(arc4random_uniform(UInt32(num)))
    }
}

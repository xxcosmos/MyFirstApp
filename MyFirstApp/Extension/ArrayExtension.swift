//
//  ArrayExtension.swift
//  MyFirstApp
//
//  Created by 张啸宇 on 2020/3/4.
//  Copyright © 2020 xiaoyuu. All rights reserved.
//

import Foundation
import HandyJSON

extension Array: HandyJSON {
    
    func getRandom() -> Iterator.Element? {
        guard count > 0 else{return nil}
        return self[Int(arc4random_uniform(UInt32(count)))]
    }
    
//    public mutating func shuffle() {
//        guard count > 1 else { return }
//        for i in 0..<(count - 2) {
//            let j = Int.random(num: count - i)
//            if i != i + j {
//                swapAt(i, i+j)
//            }
//        }
//    }
    
}

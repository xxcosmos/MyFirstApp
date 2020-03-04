//
//  Stack.swift
//  MyFirstApp
//
//  Created by 张啸宇 on 2020/3/4.
//  Copyright © 2020 xiaoyuu. All rights reserved.
//

import Foundation

class Stack<T: NSObject>: NSObject{
    var items: [T]
    var count: Int {
        return items.count
    }
    var capacity: Int
    
    init(capacity: Int) {
        self.items = [T]()
        self.capacity = capacity
        super.init()
    }
    
    func push(item: T){
        self.items.append(item)
        if count > capacity{
            items.removeFirst()
        }
    }
    
    func pop() -> T? {
        guard count > 0 else { return nil}
        return items.removeLast()
        
    }
}

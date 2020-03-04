//
//  CommonExtension.swift
//  MyFirstApp
//
//  Created by 张啸宇 on 2020/1/20.
//  Copyright © 2020 xiaoyuu. All rights reserved.
//

import Foundation
import UIKit





extension UINavigationController {
    
    func getPreviousViewController() -> UIViewController? {
        guard self.navigationController?.viewControllers != nil else {
            return nil
        }
        
        guard (self.navigationController?.viewControllers.count)! > 1 else {
            return nil
        }
        
        guard self.navigationController?.topViewController == self else {
            return nil
        }
        
        let count = self.navigationController?.viewControllers.count
        return ((self.navigationController?.viewControllers[count!-2])!)
        
    }
}

extension String {
    func getMD5() -> String {
        let str = self.cString(using: .utf8)
        let strLength = CC_LONG(self.lengthOfBytes(using: .utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        
        CC_MD5(str!, strLength, result)
        
        
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        result.deallocate()
        return String(format: hash as String)
    }
}

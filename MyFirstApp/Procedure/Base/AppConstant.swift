//
//  AppConstant.swift
//  MyFirstApp
//
//  Created by 张啸宇 on 2019/12/22.
//  Copyright © 2019 xiaoyuu. All rights reserved.
//

import Foundation
import UIKit

typealias XYBlock = () -> Void
let XYButtonColor = UIColor(red: 242/255.0, green: 77/255.0, blue: 51/255.0, alpha: 1)

let isIphoneX = ScreenHeight == 812 ? true : false

let TabBarHeight: CGFloat = isIphoneX ? 49 + 34 : 49
let NavBarHeight: CGFloat = isIphoneX ? 88 : 64
let ScreenHeight = UIScreen.main.bounds.size.height
let ScreenWidth = UIScreen.main.bounds.size.width
let SafeBounds = CGRect(x: 0, y: NavBarHeight, width: ScreenWidth, height: ScreenHeight - NavBarHeight)




var ShowStartCity: ShowStartCityModel = ShowStartCityModel(cityName: "杭州", cityCode: "571", cityName_en: "HANGZHOU")

struct Key {
    static let showStartSearchHistoryKey = "searchHistoryKey"
    static let showStartzCityKey = "cityKey"
}

public func delay(by delayTime: TimeInterval, qosClass: DispatchQoS.QoSClass? = nil, _ closure: @escaping () -> Void) {
    let dispatchQueue = qosClass != nil ? DispatchQueue.global(qos: qosClass!) : .main
    dispatchQueue.asyncAfter(deadline: DispatchTime.now() + delayTime, execute: closure)
}

// MARK:强制旋转屏幕
//
//extension UIApplication {
//    //MRAK: 强制旋转屏幕
//    class func changeOrientationTo(landscapeRight: Bool) {
//        guard let delegate = UIApplication.shared.delegate as? AppDelegate else { return }
//        if landscapeRight == true {
//            delegate.orientation = .landscapeRight
//            UIApplication.shared.supportedInterfaceOrientations(for: delegate.window)
//            UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
//        } else {
//            delegate.orientation = .portrait
//            UIApplication.shared.supportedInterfaceOrientations(for: delegate.window)
//            UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
//        }
//    }
//}
//
//

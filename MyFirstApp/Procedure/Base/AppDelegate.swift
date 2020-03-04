//
//  AppDelegate.swift
//  MyFirstApp
//
//  Created by 张啸宇 on 2019/12/9.
//  Copyright © 2019 xiaoyuu. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = XYTabBarController()
        window?.makeKeyAndVisible()
        window?.backgroundColor = UIColor.white
        
        return true
    }
    
 
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }
    

}


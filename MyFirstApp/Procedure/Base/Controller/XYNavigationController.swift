//
//  XYNavigationController.swift
//  MyFirstApp
//
//  Created by 张啸宇 on 2020/1/20.
//  Copyright © 2020 xiaoyuu. All rights reserved.
//

import UIKit

class XYNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBarAppearence()
    }
    
    func setupNavBarAppearence() {
        WRNavigationBar.defaultNavBarBarTintColor = UIColor.white
        WRNavigationBar.defaultNavBarTintColor = XYButtonColor
        WRNavigationBar.defaultNavBarTitleColor = UIColor.black
    
        WRNavigationBar.defaultShadowImageHidden = true
    }

}

extension XYNavigationController {
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if children.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
}

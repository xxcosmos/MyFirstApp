//
//  XYTabBarController.swift
//  MyFirstApp
//
//  Created by 张啸宇 on 2020/2/12.
//  Copyright © 2020 xiaoyuu. All rights reserved.
//

import UIKit

class XYTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "tabbar"
        tabBar.shadowImage = R.image.transparent()
        let homeNav = getNav(XYHomeViewController(), title: "首页", image: R.image.home(), selectedImage: R.image.home_selected())
        let mineNav = getNav(XYMineViewController(), title: "我的", image: R.image.mine(), selectedImage: R.image.mine_selected())
        
        viewControllers = [homeNav, mineNav]
    }
    
    
    func getNav(_ root: UIViewController, title: String?, image: UIImage?, selectedImage: UIImage?) -> XYNavigationController {
        root.title = title
        root.tabBarItem = UITabBarItem(title: title, image: image?.withRenderingMode(.alwaysOriginal), selectedImage: selectedImage?.withRenderingMode(.alwaysOriginal))
        root.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        return XYNavigationController(rootViewController: root)
    }
    
}

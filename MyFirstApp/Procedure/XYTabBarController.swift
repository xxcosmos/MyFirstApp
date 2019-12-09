//
//  XYTabBarController.swift
//  MyFirstApp
//
//  Created by 张啸宇 on 2019/12/9.
//  Copyright © 2019 xiaoyuu. All rights reserved.
//

import UIKit

class XYTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.isTranslucent = false
        
        let homeVC = XYHomeViewController()
        addChildVC(homeVC, title: "首页", image: R.image.home(), selectedImage: R.image.home_selected())
        
        let mineVC = XYMineViewController()
        addChildVC(mineVC, title: "我的", image: R.image.mine(), selectedImage: R.image.mine_selected())
        
    }
    
    func addChildVC(_ childVC: UIViewController, title: String?, image: UIImage?, selectedImage: UIImage?) {
        childVC.title = title
        childVC.tabBarItem.title = nil
        childVC.tabBarItem.image = image?.withRenderingMode(.alwaysOriginal)
        childVC.tabBarItem.selectedImage = selectedImage?.withRenderingMode(.alwaysOriginal)
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            childVC.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        }
        
        addChild(XYNavigationController(rootViewController: childVC))
    }
}

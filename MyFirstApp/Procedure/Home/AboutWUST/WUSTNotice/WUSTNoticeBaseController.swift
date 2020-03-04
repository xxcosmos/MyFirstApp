//
//  WUSTNoticeBaseController.swift
//  MyFirstApp
//
//  Created by 张啸宇 on 2020/1/31.
//  Copyright © 2020 xiaoyuu. All rights reserved.
//

import UIKit

class WUSTNoticeBaseController: XYBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "通知中心"
        let style = PageStyle()
        style.isTitleViewScrollEnabled = true
        style.isTitleScaleEnabled = true
        style.isShowBottomLine = true
        style.isShowCoverView = false
        style.titleSelectedColor = UIColor.black
        style.titleColor = UIColor.gray
        style.bottomLineColor = XYButtonColor
        style.bottomLineHeight = 2
        
        let titles = ["校园通知","教务通知","学工通知","科研通知"]
        let viewControllers = [WUSTNoticeController(noticeType: "tz1",navigationVC: self.navigationController),WUSTNoticeController(noticeType: "tz2",navigationVC: self.navigationController),WUSTNoticeController(noticeType: "tz3",navigationVC: self.navigationController),WUSTNoticeController(noticeType: "tz4",navigationVC: self.navigationController)]
        
        let pageView = XYPageView(frame: CGRect(x: 0, y: NavBarHeight, width: ScreenWidth, height: ScreenHeight - NavBarHeight - 30), style: style, titles: titles, children: viewControllers)
        
        view.addSubview(pageView)
    }
    
}

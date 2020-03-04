//
//  JwcController.swift
//  MyFirstApp
//
//  Created by 张啸宇 on 2020/2/22.
//  Copyright © 2020 xiaoyuu. All rights reserved.
//

import UIKit

class JwcController: XYBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    func setupUI() {
        self.title = "武科教务"
        
        let style = PageStyle()
        style.isShowCoverView = false
        style.coverViewHeight = 25
        style.isShowBottomLine = true
        style.bottomLineColor = XYButtonColor
        style.bottomLineHeight = 2
        style.bottomLineWidth = 0
        style.isTitleScaleEnabled = false
        style.isContentScrollEnabled = true
        style.isTitleViewScrollEnabled = true
        
        
        
        let titles = ["学生成绩","已选课程","学分统计"]
        let children = [JwcGradeController(),JwcChosenCourseController(),JwcCreditController()]
        let pageView = XYPageView(frame: CGRect(x: 0, y: NavBarHeight, width: ScreenWidth, height: ScreenHeight - NavBarHeight), style: style, titles: titles, children: children)
        view.addSubview(pageView)
        
    }
 

}

//
//  PageStyle.swift
//  MyFirstApp
//
//  Created by 张啸宇 on 2020/2/14.
//  Copyright © 2020 xiaoyuu. All rights reserved.
//

import UIKit

public class PageStyle {
    
    public var titleViewHeight: CGFloat = 25
    public var titleColor: UIColor = .black
    public var titleSelectedColor: UIColor = .blue
    public var titleFont: UIFont = .systemFont(ofSize: 15)
    public var titleViewBackgroundColor: UIColor = .white
    public var titleMargin: CGFloat = 30
    public var titleViewSelectedColor: UIColor = .clear
    
    public var isTitleViewScrollEnabled = true
    
    public var isShowBottomLine = true
    public var bottomLineColor: UIColor = .blue
    public var bottomLineHeight: CGFloat = 2
    public var bottomLineWidth: CGFloat = 0
    public var bottomLineRadius: CGFloat = 1
    
    /// title  缩放
    public var isTitleScaleEnabled = true
    public var titleMaximumScaleFactor: CGFloat = 1.5
    
    public var isShowCoverView = true
    public var coverViewBackgroundColor: UIColor = .black
    public var coverViewAlpha: CGFloat = 0.4
    public var coverMargin: CGFloat = 8
    public var coverViewHeight: CGFloat = 25
    public var coverViewRadius: CGFloat = 12
    
    public var isContentScrollEnabled  = true
    public var contentViewBackgroundColor: UIColor = .white
    
    public init() {}
}

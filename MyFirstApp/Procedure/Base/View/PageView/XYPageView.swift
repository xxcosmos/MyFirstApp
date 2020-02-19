//
//  XYPageView.swift
//  MyFirstApp
//
//  Created by 张啸宇 on 2020/2/14.
//  Copyright © 2020 xiaoyuu. All rights reserved.
//

import UIKit
@objc  protocol PageViewDelegate: class {
    func pageView(_ pageView: XYPageView,didShowAt index: Int)
    @objc optional func pageView(_ pageView: XYPageView, scrollingWith sourceIndex: Int, targetIndex: Int, progress: CGFloat)
    @objc optional func pageView(_ pageView: XYPageView, viewDidDisappearAt index: Int)
    @objc optional func pageView(_ pageView: XYPageView, DidTapedSameTitleAt index:Int)
}
class XYPageView: UIView {
    public weak var delegate: PageViewDelegate?
    private (set) public var style: PageStyle
    private (set) public var titles: [String]
    private (set) public var children: [UIViewController]
    private (set) public var startIndex: Int
    private (set) public lazy var titleView = PageTitleView(frame: .zero, style: style, titles: titles, currentIndex: startIndex)
    private (set) public lazy var contentView = PageContentView(frame: .zero, style: style, children: children, currentIndex: startIndex)
    
    public init(frame: CGRect, style: PageStyle, titles: [String], children: [UIViewController], startIndex: Int = 0) {
        self.style = style
        self.titles = titles
        self.children = children
        self.startIndex = startIndex
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupUI() {
        titleView.frame = CGRect(x: 0, y: 0, width: bounds.width, height: style.titleViewHeight)
        addSubview(titleView)
        
        contentView.frame = CGRect(x: 0, y: style.titleViewHeight, width: bounds.width, height: bounds.height)
        addSubview(contentView)
        
        contentView.delegate = self
        titleView.delegate = self
        
    }
    

}

extension XYPageView: PageTitleViewDelegate, PageContentViewDelegate {

    func pageTitleView(_ titleView: PageTitleView, didSelectedSameTitle index: Int) {
        self.delegate?.pageView?(self, DidTapedSameTitleAt: index)
    }
    func pageTitleView(_ titleView: PageTitleView, didSelectAt index: Int) {
        self.delegate?.pageView(self, didShowAt: index)
        contentView.isForbidDelegate = true
        guard contentView.currentIndex < contentView.children.count else { return }
        contentView.currentIndex = index
        contentView.collectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: .left, animated: true)
    }
    func pageContentView(_ contentView: PageContentView, ViewDidDisappearAt index: Int) {
        self.delegate?.pageView?(self, viewDidDisappearAt: index)
    }
    func pageContentView(_ contentView: PageContentView, didEndScrollTo index: Int) {
        let titleLabels = titleView.titleLabels
        let sourceLabel =  titleLabels[titleView.currentIndex]
        let targetLabel = titleLabels[index]
        
        titleView.fixUI(sourceLabel: sourceLabel, targetLabel: targetLabel)
        if index != titleView.currentIndex {
            self.delegate?.pageView(self, didShowAt: index)
            titleView.currentIndex = index
        }
        
    }
    
    func pageContentView(_ contentView: PageContentView, scrollingWith sourceIndex: Int, targetIndex: Int, progress: CGFloat) {
        self.delegate?.pageView?(self, scrollingWith: sourceIndex, targetIndex: targetIndex, progress: progress)
        let titleLabels = titleView.titleLabels
        guard sourceIndex < titleLabels.count && sourceIndex >= 0 else { return }
        guard targetIndex < titleLabels.count && targetIndex >= 0 else { return }
        
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
//        let (sr,sg,sb) = style.titleSelectedColor.getRGB()
//        let (tr,tg,tb) = style.titleColor.getRGB()
//        let (dr,dg,db) = ((sr - tr) * progress,(sg - tg) * progress,(sb - tb) * progress)
//        sourceLabel.textColor = UIColor(red: sr - dr, green: sg - dg, blue: sb - db, alpha: 1)
//        targetLabel.textColor = UIColor(red: tr + dr, green: tg + dg, blue: tb + db, alpha: 1)
        
        titleView.layoutTitle(progress: progress, sourceLabel: sourceLabel, targetLabel: targetLabel)
    }
}



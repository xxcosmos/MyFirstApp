//
//  PageTitleView.swift
//  MyFirstApp
//
//  Created by 张啸宇 on 2020/2/14.
//  Copyright © 2020 xiaoyuu. All rights reserved.
//

import UIKit

protocol PageTitleViewDelegate: class {
    
    func pageTitleView(_ titleView: PageTitleView, didSelectAt index: Int)
    func pageTitleView(_ titleView: PageTitleView, didSelectedSameTitle index: Int)
}



class PageTitleView: UIView {
    
    public weak var delegate: PageTitleViewDelegate?
    
    
    public var currentIndex: Int
    private (set) public lazy var titleLabels: [UILabel] = [UILabel]()
    public var style: PageStyle
    public var titles: [String]
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        return scrollView
    }()
    
    private lazy var bottomLine: UIView = {
        let line = UIView()
        line.backgroundColor = self.style.bottomLineColor
        line.layer.cornerRadius = self.style.bottomLineRadius
        return line
    }()
    
    private (set) public lazy var coverView: UIView = {
        let cover = UIView()
        cover.backgroundColor = self.style.coverViewBackgroundColor
        cover.alpha = self.style.coverViewAlpha
        cover.layer.cornerRadius = style.coverViewRadius
        cover.layer.masksToBounds = true
        return cover
    }()
    
    public init(frame: CGRect, style: PageStyle, titles: [String], currentIndex: Int){
        self.style = style
        self.titles = titles
        self.currentIndex = currentIndex
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        self.style = PageStyle()
        self.titles = [String]()
        self.currentIndex = 0
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        scrollView.frame = self.bounds
        setupLabelsLayout()
        setupBottomLineLayout()
        setupCoverViewLayout()
    }
    
}

extension PageTitleView {
    private func setupLabelsLayout() {
        
        var x: CGFloat = 0
        let y: CGFloat = 0
        var width: CGFloat = 0
        let height = frame.height
        let label  = titleLabels[currentIndex]
        let count = titleLabels.count
        
        for (i, titleLabel) in titleLabels.enumerated() {
            if style.isTitleViewScrollEnabled {
                width = (titles[i] as NSString).boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: 0), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : style.titleFont], context: nil).width
                x = i == 0 ? style.titleMargin * 0.5 : (titleLabels[i - 1].frame.maxX + style.titleMargin)
            } else {
                width = frame.width / CGFloat(count)
                x = width * CGFloat(i)
            }
            titleLabel.transform = CGAffineTransform.identity
            titleLabel.frame = CGRect(x: x, y: y, width: width, height: height)
        }
        
        if style.isTitleScaleEnabled {
            label.transform = CGAffineTransform(scaleX: style.titleMaximumScaleFactor, y: style.titleMaximumScaleFactor)
        }
        
        if style.isTitleViewScrollEnabled, let titleLabel = titleLabels.last {
            scrollView.contentSize.width = titleLabel.frame.maxX + style.titleMargin * 0.5
        }
    }
    
    private func setupCoverViewLayout() {
        guard currentIndex < titleLabels.count else { return }
        let label = titleLabels[currentIndex]
        var width = label.frame.width
        let height = style.coverViewHeight
        if style.isTitleViewScrollEnabled {
            width += 2 * style.coverMargin
        }
        coverView.frame.size = CGSize(width: width, height: height)
        coverView.center = label.center
    }
    
    private func setupBottomLineLayout() {
        guard currentIndex < titleLabels.count else { return }
        let label = titleLabels[currentIndex]
        
        bottomLine.frame.size.width = style.bottomLineWidth > 0 ? style.bottomLineWidth : label.frame.width
        bottomLine.frame.size.height = style.bottomLineHeight
        bottomLine.center.x = label.center.x
        bottomLine.frame.origin.y = frame.height - bottomLine.frame.height
    }
    
    public func setupUI() {
        addSubview(scrollView)
        scrollView.backgroundColor = style.titleViewBackgroundColor
        
        if style.isShowCoverView {
            scrollView.insertSubview(coverView, at: 0)
        }
        
        if style.isShowBottomLine {
            scrollView.addSubview(bottomLine)
        }
        
        for (index,title) in titles.enumerated() {
            let label = UILabel()
            label.tag = index
            label.text = title
            label.textColor = index == currentIndex ? style.titleSelectedColor : style.titleColor
            label.backgroundColor = index == currentIndex ? style.titleViewSelectedColor : .clear
            label.textAlignment = .center
            label.font = style.titleFont
            label.isUserInteractionEnabled = true
            
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(tapedTitleLabel(_:)))
            label.addGestureRecognizer(tapGes)
            
            scrollView.addSubview(label)
            titleLabels.append(label)
        }
        
    }
    
    @objc private func tapedTitleLabel(_ tapGes: UITapGestureRecognizer) {
        guard let index = tapGes.view?.tag  else {return}
        guard index >= 0 && index < titles.count else {return}
        
        guard index != currentIndex else {
            delegate?.pageTitleView(self, didSelectedSameTitle: index)
            return
        }
        
        delegate?.pageTitleView(self, didSelectAt: index)
        
        let sourceLabel = titleLabels[currentIndex]
        let targetLabel = titleLabels[index]
        
        currentIndex = index
        
        fixUI(sourceLabel: sourceLabel, targetLabel: targetLabel)
    }
    
    
    func fixUI(sourceLabel: UILabel, targetLabel: UILabel) {
        self.titleLabels.forEach { $0.textColor = style.titleColor}
        targetLabel.textColor = style.titleSelectedColor
        sourceLabel.backgroundColor = .clear
        targetLabel.backgroundColor = style.titleViewSelectedColor
        
        if style.isTitleViewScrollEnabled,scrollView.contentSize.width > scrollView.frame.width {
            var offsetX = targetLabel.center.x - frame.width * 0.5
            if offsetX > 0 {
                if offsetX > scrollView.contentSize.width - scrollView.frame.width {
                    offsetX = scrollView.contentSize.width - scrollView.frame.width
                }
                scrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
            }
        }
        
        UIView.animate(withDuration: 0.25) {
            self.layoutTitle(progress: 0, sourceLabel: targetLabel, targetLabel: sourceLabel)
        }
        
    }
    
    
    func layoutTitle(progress: CGFloat, sourceLabel: UILabel, targetLabel: UILabel) {
        
        let deltaWidth = targetLabel.frame.width - sourceLabel.frame.width
        let deltaCenterX = targetLabel.center.x - sourceLabel.center.x
        let deltaScale = style.titleMaximumScaleFactor - 1.0
        
        if style.isTitleScaleEnabled {
            sourceLabel.transform = CGAffineTransform(scaleX: style.titleMaximumScaleFactor - progress * deltaScale, y: style.titleMaximumScaleFactor - progress * deltaScale)
            targetLabel.transform = CGAffineTransform(scaleX: 1.0 + progress * deltaScale, y: 1.0 + progress * deltaScale)
        }
        
        if style.isShowBottomLine {
            bottomLine.frame.size.width = style.bottomLineWidth > 0 ? style.bottomLineWidth : sourceLabel.frame.width + progress * deltaWidth
            bottomLine.center.x = sourceLabel.center.x + progress * deltaCenterX
        }
        
        if style.isShowCoverView {
            coverView.frame.size.width = style.isTitleViewScrollEnabled ? (sourceLabel.frame.width + 2 * style.coverMargin + deltaWidth * progress) : (sourceLabel.frame.width + deltaWidth * progress)
            coverView.center.x = sourceLabel.center.x + deltaCenterX * progress
        }
    }
}

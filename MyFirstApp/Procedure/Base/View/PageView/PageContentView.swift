//
//  PageContentView.swift
//  MyFirstApp
//
//  Created by 张啸宇 on 2020/2/14.
//  Copyright © 2020 xiaoyuu. All rights reserved.
//
    
import UIKit

protocol PageContentViewDelegate: class {
    func pageContentView(_ contentView: PageContentView, didEndScrollTo index: Int)
    func pageContentView(_ contentView: PageContentView, scrollingWith sourceIndex: Int, targetIndex: Int, progress: CGFloat)
    func pageContentView(_ contentView: PageContentView, ViewDidDisappearAt index: Int)
    
}

class CollectionViewPageLayout: UICollectionViewFlowLayout {
    var offset: CGFloat?
    override func prepare() {
        super.prepare()
        guard let offset = offset else {return}
        collectionView?.contentOffset = CGPoint(x: offset, y: 0)
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        scrollDirection = .horizontal
    }
}

class PageContentView: UIView {
    public weak var delegate: PageContentViewDelegate?
  
    public var style: PageStyle
    var children: [UIViewController]

    var currentIndex: Int
    private var startOffsetX: CGFloat = 0
    var isForbidDelegate: Bool = false
    
    private (set) public lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: CollectionViewPageLayout())
        collection.showsHorizontalScrollIndicator = false
        collection.isPagingEnabled = true
        collection.scrollsToTop = false
        collection.bounces = false
        collection.isPrefetchingEnabled = false
        
        collection.delegate = self
        collection.dataSource = self
        collection.register(cellType: XYBaseCollectionCell.self)
        
        return collection
    }()
    
  
    public init(frame: CGRect, style: PageStyle, children: [UIViewController], currentIndex: Int) {
        self.style = style
        self.children = children
        self.currentIndex = currentIndex
        super.init(frame: frame)
        
        
        addSubview(collectionView)
        collectionView.backgroundColor = style.contentViewBackgroundColor
        collectionView.isScrollEnabled = style.isContentScrollEnabled
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = bounds
        let layout = collectionView.collectionViewLayout as! CollectionViewPageLayout
        layout.itemSize = bounds.size
        layout.offset = CGFloat(currentIndex) * bounds.size.width
    }
}


extension PageContentView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return children.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: XYBaseCollectionCell.self)
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
        
        let vc = children[indexPath.item]
        vc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(vc.view)
        
        return cell
    }
    
    private func collectionViewDidendScroll(_ scrollView: UIScrollView) {
        let index = Int(round(scrollView.contentOffset.x / scrollView.bounds.width))
        delegate?.pageContentView(self, didEndScrollTo: index)
        guard index != currentIndex else { return }
        
        delegate?.pageContentView(self, ViewDidDisappearAt: currentIndex)

        currentIndex = index
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidDelegate = false
        startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        guard !decelerate else { return }
        collectionViewDidendScroll(scrollView)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        collectionViewDidendScroll(scrollView)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard !isForbidDelegate  else { return }
        var progress = scrollView.contentOffset.x.truncatingRemainder(dividingBy: scrollView.bounds.width) / scrollView.bounds.width
        guard progress != 0 && !progress.isNaN else { return }
        
        let index = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        var sourceIndex = 0
        var targetIndex = 0
        
        if collectionView.contentOffset.x > startOffsetX { // 左滑动
            sourceIndex = index
            targetIndex = index + 1
        } else {
            sourceIndex = index + 1
            targetIndex = index
            progress = 1 - progress
        }
        
        guard targetIndex >= 0 && targetIndex < children.count else { return }
        
        if progress > 0.998 { progress = 1 }
        
        delegate?.pageContentView(self, scrollingWith: sourceIndex, targetIndex: targetIndex, progress: progress)
    }
    
}

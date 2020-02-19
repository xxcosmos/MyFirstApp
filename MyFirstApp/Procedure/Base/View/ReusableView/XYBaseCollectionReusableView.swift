//
//  XYBaseCollectionReusableView.swift
//  MyFirstApp
//
//  Created by 张啸宇 on 2020/2/13.
//  Copyright © 2020 xiaoyuu. All rights reserved.
//

import UIKit
import Reusable
    
class XYBaseCollectionReusableView: UICollectionReusableView, Reusable {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    open func setupUI() {}
}

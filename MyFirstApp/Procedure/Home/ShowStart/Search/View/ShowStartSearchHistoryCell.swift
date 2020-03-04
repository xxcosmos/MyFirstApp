//
//  ShowStartSearchHistoryCell.swift
//  MyFirstApp
//
//  Created by 张啸宇 on 2020/2/12.
//  Copyright © 2020 xiaoyuu. All rights reserved.
//

import UIKit

class ShowStartSearchHistoryCell: XYBaseCollectionCell {
    
    lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.textAlignment = .center
        title.font = .systemFont(ofSize: 14)
        title.textColor = .darkGray
        
        return title
    }()
    
    override func setupUI() {
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
        layer.cornerRadius = bounds.height * 0.3
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 6, left: 10, bottom: 6, right: 10))
        }
    }
  
    
    
}

//
//  ShowStartSearchBar.swift
//  MyFirstApp
//
//  Created by 张啸宇 on 2020/2/13.
//  Copyright © 2020 xiaoyuu. All rights reserved.
//

import UIKit

class ShowStartSearchBar: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = CGRect(x: 0, y: 0, width: ScreenWidth - 50, height: 30)
        self.backgroundColor = UIColor.gray.withAlphaComponent(0.2)
        self.textColor = .black
        self.tintColor = .darkGray
        self.font = .systemFont(ofSize: 15)
        self.placeholder = "演出/周边/众筹/小站"
        self.layer.cornerRadius = 15
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 15))
        self.leftViewMode = .always
        self.clearsOnBeginEditing = false
        self.clearButtonMode = .always
        self.returnKeyType = .search
        //        self.becomeFirstResponder()
        self.keyboardType = .default
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class ShowStartSearchBarButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = CGRect(x: 0, y: 0, width: ScreenWidth - 20, height: 30)
        self.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        self.layer.cornerRadius = 15
        self.setTitle("想要找点什么？", for: .normal)
        self.setTitleColor(.gray, for: .normal)
        self.tintColor = .gray
        self.setImage(R.image.nav_search()?.withTintColor(.gray, renderingMode: .alwaysTemplate), for: .normal)
        self.contentHorizontalAlignment = ContentHorizontalAlignment.left
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 5)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  ShowStartCityButton.swift
//  MyFirstApp
//
//  Created by 张啸宇 on 2020/1/31.
//  Copyright © 2020 xiaoyuu. All rights reserved.
//

import UIKit

class ShowStartCityButton: UIButton {
    
    private var picView: UIImageView = {
        let picView = UIImageView()
        picView.image = R.image.location()
        return picView
    }()
    
    var textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        addSubview(picView)
        picView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(5)
            make.top.equalToSuperview().offset(7)
            make.width.height.equalTo(20)
        }
        
        addSubview(textLabel)
        textLabel.snp.makeConstraints { (make) in
            make.left.equalTo(picView.snp.right).offset(5)
            make.right.equalToSuperview()
            make.top.height.equalTo(picView)
        }
    }
    
    
}

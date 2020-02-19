//
//  WUSTNoticeCell.swift
//  MyFirstApp
//
//  Created by 张啸宇 on 2020/1/31.
//  Copyright © 2020 xiaoyuu. All rights reserved.
//

import UIKit

class WUSTNoticeCell: XYBaseTableCell {
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.numberOfLines = 2
        return label
    }()
    
    private var authorLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        return label
    }()
    
    private var timeLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        return label
    }()
    

    
    override func setupUI(){
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(15)
            make.right.equalToSuperview()
            make.height.equalTo(50)
        }
        
        addSubview(authorLabel)
        authorLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.height.equalTo(15)
        }
        
        addSubview(timeLabel)
        timeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.bottom.equalToSuperview().offset(-10)
            make.height.equalTo(15)
        }
    }
    
    var localModel: WUSTNoticeDataModel? {
        didSet {
            guard let model = localModel else {return}
            self.titleLabel.text = model.title
            self.authorLabel.text = model.auther
            self.timeLabel.text = model.publishTime
        }
    }
}

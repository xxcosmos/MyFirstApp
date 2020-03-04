//
//  ShowStartShowCell.swift
//  MyFirstApp
//
//  Created by 张啸宇 on 2020/1/20.
//  Copyright © 2020 xiaoyuu. All rights reserved.
//

import UIKit
import Kingfisher

class ShowStartShowCell: XYBaseTableCell {
    
    private var picView: UIImageView = {
        let picView = UIImageView()
        picView.layer.masksToBounds = true
        picView.layer.cornerRadius = 5
        picView.image = R.image.signature()
        return picView
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.numberOfLines = 2
        return label
    }()
    
    private var performerLabel : UILabel = {
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
    
    private var siteLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        return label
    }()
    
    private var priceLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .red
        return label
    }()
    
    
    
    override func setupUI(){
        

        
        addSubview(picView)
        picView.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-15)
            make.width.equalTo(160)
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(picView.snp.right).offset(10)
            make.right.equalToSuperview()
            make.top.equalTo(picView)
            make.height.equalTo(50)
        }
        
        addSubview(performerLabel)
        performerLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(titleLabel)
            make.height.equalTo(20)
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
        }
        
        addSubview(timeLabel)
        timeLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(titleLabel)
            make.height.equalTo(performerLabel)
            make.top.equalTo(performerLabel.snp.bottom).offset(10)
        }
        
        addSubview(siteLabel)
        siteLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(titleLabel)
            make.height.equalTo(performerLabel)
            make.top.equalTo(timeLabel.snp.bottom).offset(10)
        }
        
        addSubview(priceLabel)
        priceLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(titleLabel)
            make.height.equalTo(performerLabel)
            make.top.equalTo(siteLabel.snp.bottom).offset(30)
        }
    }

    
    var localShowStartModel: ShowStartShowModel? {
        didSet {
            guard let model = localShowStartModel else {return}
            self.picView.kf.setImage(with: URL(string: model.avatar!))
            self.titleLabel.text = model.title
            self.performerLabel.text = "表演者：\(model.performerName ?? "-")"
            self.siteLabel.text = "\(model.city ?? "-") \(model.siteName ?? "-")"
            self.timeLabel.text = model.showTime
            self.priceLabel.text = model.activityPrice
        }
    }
    
}

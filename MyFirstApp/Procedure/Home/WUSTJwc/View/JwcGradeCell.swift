//
//  JwcGradeCell.swift
//  MyFirstApp
//
//  Created by 张啸宇 on 2020/2/22.
//  Copyright © 2020 xiaoyuu. All rights reserved.
//

import UIKit

class JwcGradeCell: UIView {
    
    var localModel: GradeModel? {
        didSet {
            guard let model = localModel else {return}
            courseNameLabel.text = "\(model.kcmc ?? "UNKNOWN")"
            gradeLabel.text = "绩点：\(model.jd ?? -1)  成绩：\(model.zcj ?? "-")"
            detailLabel.text = "学分：\(model.xf ?? -1)\n总学时：\(model.zxs ?? -1)\n\(model.kclbmc ?? "")\n\(model.kcxzmc ?? "")\n\(model.ksxzmc ?? "")\n\(model.kkxq ?? "")"
            
            if let point  = model.jd {
                if point > 3 {
                    self.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.2)
                } else if point >= 2.0 {
                    self.backgroundColor = UIColor.systemOrange.withAlphaComponent(0.2)
                } else {
                    self.backgroundColor = UIColor.systemRed.withAlphaComponent(0.2)
                }
            }
            
        }
    }
    
    private var courseNameLabel = UILabel().then { (label) in
        label.font = .boldSystemFont(ofSize: 15)
        label.textAlignment = .center
        label.textColor = .black
        label.numberOfLines = 2
    }
    
    private var gradeLabel = UILabel().then { (label) in
        label.font = .systemFont(ofSize: 13)
        label.textColor = .purple
        label.textAlignment = .center
    }
    
    private var detailLabel = UILabel().then { (label) in
        label.font = .systemFont(ofSize: 13)
        label.textColor = .gray
        label.numberOfLines = 10
        label.textAlignment = .center
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.layer.cornerRadius = 15
        
        addSubview(courseNameLabel)
        courseNameLabel.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-8)
            make.height.equalTo(40)
        }
        
        addSubview(gradeLabel)
        gradeLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(courseNameLabel)
            make.top.equalTo(courseNameLabel.snp.bottom).offset(5)
            make.height.equalTo(15)
        }
        
        addSubview(detailLabel)
        detailLabel.snp.makeConstraints { (make) in
            make.top.equalTo(gradeLabel.snp.bottom).offset(-5)
            make.left.right.equalTo(courseNameLabel)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    
}

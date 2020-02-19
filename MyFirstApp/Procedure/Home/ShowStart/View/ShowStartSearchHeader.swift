//
//  ShowStartSearchHistoryHeaderView.swift
//  MyFirstApp
//
//  Created by 张啸宇 on 2020/2/13.
//  Copyright © 2020 xiaoyuu. All rights reserved.
//

import UIKit

typealias SearchHistoryDeletedClosure = () -> Void



class ShowStartSearchHistoryHead: XYBaseCollectionReusableView {
    
    private var searchHistoryDeletedClosure: SearchHistoryDeletedClosure?
    
    func deletedSearchHistoryClosure(_ closure: @escaping SearchHistoryDeletedClosure) {
        searchHistoryDeletedClosure = closure
    }
    
    private lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.textAlignment = .left
        title.font = .systemFont(ofSize: 20)
        title.textColor = .black
        title.text = "历史搜索"
        
        return title
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(R.image.search_history_delete()?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(deleteAction), for: .touchUpInside)
        return button
    }()
    
    @objc func deleteAction(button: UIButton){
        guard let actionClosure = searchHistoryDeletedClosure else {return}
        actionClosure()
    }
    
    override func setupUI() {
        backgroundColor = .white
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(200)
        }
        
        addSubview(button)
        button.snp.makeConstraints { (make) in
            make.top.right.bottom.equalToSuperview()
            make.width.equalTo(40)
        }
    }
}

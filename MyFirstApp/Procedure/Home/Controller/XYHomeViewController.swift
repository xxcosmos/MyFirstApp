//
//  XYHomeViewController.swift
//  MyFirstApp
//
//  Created by 张啸宇 on 2019/12/9.
//  Copyright © 2019 xiaoyuu. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

struct CellModel {
    var name: String
    var page: XYBaseViewController
}

class XYHomeViewController: XYBaseViewController {
    
    var tableView:UITableView!
    let items = Observable.just([
        CellModel(name: "免费校园网", page: XYWirelessViewController()),
        CellModel(name: "查询已选课程", page: XYChosenCourseViewController()),
    ])
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView()
        tableView.tableFooterView = UIView()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        items.bind(to: tableView.rx.items) { (tableView, row, element) in
            let cell  = tableView.dequeueReusableCell(withIdentifier: "Cell")
            cell?.textLabel?.text = "\(row+1): \(element.name)"
            return cell!
        }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(CellModel.self).subscribe(onNext: { (cellModel) in
            self.navigationController?.pushViewController(cellModel.page, animated: true)
            }).disposed(by: disposeBag)
       
        
//        Observable.zip(tableView.rx.itemSelected, tableView.rx.modelSelected(String.self)).bind {[weak self] indexPath, item in
//            self?.showToast("hello")
//            print("选中的 indexPath 为\(indexPath.row)，选中的 item 为\(item)")
//        }.disposed(by: disposeBag)
        
    }
    
    
    
    
}

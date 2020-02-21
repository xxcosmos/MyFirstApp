//
//  XYHomeViewController.swift
//  MyFirstApp
//
//  Created by 张啸宇 on 2019/12/9.
//  Copyright © 2019 xiaoyuu. All rights reserved.
//

import UIKit
import SnapKit

struct CellModel {
    var name: String
    var page: UIViewController
}

class XYHomeViewController: XYBaseViewController {
    
    private let items = [
        CellModel(name: "免费校园网", page: XYWirelessViewController()),
        CellModel(name: "学校通知", page: WUSTNoticeBaseController()),
        CellModel(name: "演出列表", page: ShowStartViewController()),
        CellModel(name: "端口扫描", page: XYNetWorkController()),
        CellModel(name: "武科教务", page: JwcController()),
    ]
    
    private lazy var tableView = UITableView().then {
        $0.delegate = self
        $0.dataSource = self
        $0.register(cellType: XYBaseTableCell.self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)
        tableView.snp.makeConstraints { $0.edges.equalTo(self.view.safeAreaLayoutGuide.snp.edges)}
        
    }
    
}


extension XYHomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XYBaseTableCell.self)
        cell.textLabel?.text = items[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(items[indexPath.row].page, animated: true)
    }
}

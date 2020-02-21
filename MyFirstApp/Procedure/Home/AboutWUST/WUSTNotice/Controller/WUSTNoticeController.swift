//
//  WUSTNoticeController.swift
//  MyFirstApp
//
//  Created by 张啸宇 on 2020/1/31.
//  Copyright © 2020 xiaoyuu. All rights reserved.
//

import UIKit

class WUSTNoticeController: XYBaseViewController {
    
    var noticeType: String?

    var navigationVC: UINavigationController?
    
    lazy var viewModel : WUSTNoticeViewModel = {
        return WUSTNoticeViewModel()
    }()
    
    lazy var tableView : UITableView = {
        let table = UITableView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight), style: .plain)
        table.backgroundColor = .white
        table.delegate = self
        table.dataSource = self
        table.showsVerticalScrollIndicator = false
        table.separatorStyle = .singleLine
        
        table.register(cellType: WUSTNoticeCell.self)
        
        table.uHead = URefreshHeader{[weak self] in self?.getData(isReload: true)}
        table.uFoot = URefreshAutoFooter{[weak self] in self?.getData(isReload: false)}
        
        return table
    }()
    
    
    convenience init(noticeType: String,navigationVC: UINavigationController?) {
        self.init()
        self.navigationVC = navigationVC
        self.noticeType = noticeType
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalToSuperview()
        }
        self.tableView.uHead.beginRefreshing()
    }
    

    
    func getData(isReload: Bool) {
        viewModel.getNoticeBlock = { [unowned self] in
            if isReload {
                self.tableView.uHead.endRefreshing()
            } else {
                self.tableView.uFoot.endRefreshing()
            }
            
            self.tableView.reloadData()
        }
        viewModel.getData(isReload: isReload, type: noticeType!)
        
    }
    
    
}

extension WUSTNoticeController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.notices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as WUSTNoticeCell
        cell.localModel = viewModel.notices[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let text = viewModel.notices[indexPath.row].content ?? ""
        navigationVC?.pushViewController(WUSTNoticeDetailController(text: text), animated: true)
        
    }
    

    
}

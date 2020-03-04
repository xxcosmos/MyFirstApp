//
//  JwcGradeController.swift
//  MyFirstApp
//
//  Created by 张啸宇 on 2020/2/22.
//  Copyright © 2020 xiaoyuu. All rights reserved.
//

import UIKit

class JwcGradeController: XYBaseViewController {
    
    private lazy var interfaceView = JwcGradeInterfaceView()
    private lazy var viewModel = JwcViewModel()
    
    
    
    private lazy var tableView = UITableView().then { (view) in
        view.delegate = self
        view.dataSource = self
        view.register(cellType: XYBaseTableCell.self)
        
        view.separatorStyle = .none
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(interfaceView)
        interfaceView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(110)
        }
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(interfaceView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        
        interfaceView.buttonActionBlock = {[unowned self] (studentId) in
            self.getData(studentId: studentId)
        }
        
    }
    
    func getData(studentId:String) {
        viewModel.getGradeBlock = {[unowned self] in
            self.tableView.reloadData()
            let info = self.viewModel.gradeList?[0]
            self.interfaceView.studentInfo = [info?.xm ?? "", info?.xh ?? "","\(self.viewModel.gpa!)" ]
        }
        self.viewModel.getGradeList(studentId: studentId)
    }
    
}


extension JwcGradeController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return((viewModel.gradeList?.count  ?? 0) + 1) / 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XYBaseTableCell.self)
        cell.subviews.forEach{$0.removeFromSuperview()}
        
        let index = indexPath.row * 2
        let count = viewModel.gradeList?.count ?? 0
        if index < count {
            let gradeView1 = JwcGradeCell()
            gradeView1.localModel = viewModel.gradeList?[indexPath.row * 2]
            cell.addSubview(gradeView1)
            gradeView1.snp.makeConstraints { (make) in
                make.left.top.equalToSuperview().offset(20)
                make.width.equalTo(150)
                make.bottom.equalToSuperview().offset(-20)
            }
            
        }
        if index + 1 < count {
            let gradeView2 = JwcGradeCell()
            gradeView2.localModel = viewModel.gradeList?[indexPath.row * 2 + 1]
            cell.addSubview(gradeView2)
            gradeView2.snp.makeConstraints { (make) in
                make.right.equalToSuperview().offset(-20)
                make.width.equalTo(150)
                make.top.equalToSuperview().offset(20)
                make.bottom.equalToSuperview().offset(-20)
            }
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
    
    
    
    
    
}

//
//  ShowStartCityController.swift
//  MyFirstApp
//
//  Created by 张啸宇 on 2020/1/31.
//  Copyright © 2020 xiaoyuu. All rights reserved.
//

import UIKit

class ShowStartCityController: XYBaseViewController {
    
    lazy var viewModel : ShowStartCityViewModel = {
        return ShowStartCityViewModel()
    }()
    
    lazy var tableView : UITableView = {
        let table = UITableView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight), style: .plain)
        table.backgroundColor = .white
        table.delegate = self
        table.dataSource = self
        table.showsVerticalScrollIndicator = false
        table.register(UITableViewCell.self, forCellReuseIdentifier: "city")
        table.separatorStyle = .singleLine
        
        
        return table
    }()
    
    
    var cityBlock :((_ city:ShowStartCityModel) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "选择城市"
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { $0.edges.equalTo(self.view.safeAreaLayoutGuide.snp.edges)}
        
        viewModel.getCityListBlock = { [unowned self] in
            self.tableView.reloadData()
        }
        
        viewModel.refreshDataSource()
    }
    
    
    
    
}

extension ShowStartCityController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.citys?.count ?? 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.citys?[section].cityEntry?.count ?? 0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = viewModel.citys?[indexPath.section].cityEntry?[indexPath.row]
        self.cityBlock?(city!)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "city", for: indexPath)
        let city = viewModel.citys?[indexPath.section].cityEntry?[indexPath.row].cityName
        
        cell.textLabel?.text = city
        cell.textLabel?.font = .systemFont(ofSize: 14)
        
        return cell
        
    }
    
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        guard viewModel.citys != nil else {
            return nil
        }
        
        var indices = [String]()
        
        for result in viewModel.citys! {
            indices.append(result.title!)
        }
        return indices
        
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.viewModel.citys?[section].title
    }
    
}

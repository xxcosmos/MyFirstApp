//
//  ShowStartSearchController.swift
//  MyFirstApp
//
//  Created by 张啸宇 on 2020/2/12.
//  Copyright © 2020 xiaoyuu. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class ShowStartSearchController: XYBaseViewController {
    
    private lazy var searchHistory = UserDefaults.standard.value(forKey: Key.showStartSearchHistoryKey) as? [String] ?? [String]()
    
    
    private lazy var viewModel = ShowStartSearchViewModel()
    
    
    private lazy var tableView = UITableView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight), style: .plain).then {

        $0.backgroundColor = .white
        $0.showsVerticalScrollIndicator = true
        $0.separatorStyle = .none
        
        $0.delegate = self
        $0.dataSource = self
        $0.emptyDataSetSource = self
        $0.emptyDataSetDelegate = self
        $0.register(cellType: ShowStartShowCell.self)
        
        $0.uFoot = URefreshAutoFooter{[weak self] in self?.loadData(isNew: false)}
    }
    
    //MARK: 历史搜索
    private lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewLeftAlignedLayout()
        
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10

        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.estimatedItemSize = CGSize(width: 100, height: 40)
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .white
        
        collection.delegate = self
        collection.dataSource = self
        
        collection.register(cellType: ShowStartSearchHistoryCell.self)
        collection.register(supplementaryViewType: ShowStartSearchHistoryHead.self, ofKind: UICollectionView.elementKindSectionHeader)
        
        return collection
    }()
    
    private lazy var searchBar: ShowStartSearchBar = {
        let searchBar = ShowStartSearchBar()
        searchBar.delegate = self
        searchBar.becomeFirstResponder()
        return searchBar
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.titleView = searchBar
        navigationItem.setHidesBackButton(true, animated: true)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(cancelAction))
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { $0.edges.equalTo(self.view.safeAreaLayoutGuide.snp.edges)}
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { $0.edges.equalTo(self.view.safeAreaLayoutGuide.snp.edges) }
    }
    
    private func doSearch() {
        let text = searchBar.text ?? ""
        if text.count > 0 {
            collectionView.isHidden = true
            tableView.isHidden = false
            loadData(isNew: true)
            
            searchHistory.removeAll { $0 == text}
            searchHistory.insert(text, at: 0)
            collectionView.reloadData()
            UserDefaults.standard.set(searchHistory, forKey: Key.showStartSearchHistoryKey)
            UserDefaults.standard.synchronize()
            
        } else {
            collectionView.isHidden = false
            tableView.isHidden = true
        }
    }
    
    @objc private func cancelAction() {
        searchBar.resignFirstResponder()
        navigationController?.popViewController(animated: true)
    }
    
    func loadData(isNew: Bool) {
        viewModel.updataBlock = { [unowned self] in
            
            self.tableView.reloadData()
            if !isNew {
                self.tableView.uFoot.endRefreshing()
            }
        }
        viewModel.getData(keyword: searchBar.text!, isReload: isNew)
    }
    
    
}

extension ShowStartSearchController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        collectionView.isHidden = false
        tableView.isHidden = true
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        doSearch()
        
        return textField.resignFirstResponder()
    }
}

extension ShowStartSearchController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchHistory.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: ShowStartSearchHistoryCell.self)
        cell.titleLabel.text = searchHistory[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        searchBar.text = searchHistory[indexPath.row]
        doSearch()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let view =  collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, for: indexPath, viewType: ShowStartSearchHistoryHead.self)
        view.isHidden = searchHistory.count == 0
        view.deletedSearchHistoryClosure {[weak self] in
            self?.searchHistory.removeAll()
            self?.collectionView.reloadData()
            UserDefaults.standard.removeObject(forKey: Key.showStartSearchHistoryKey)
            UserDefaults.standard.synchronize()
        }
        return view
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: ScreenWidth, height: 35)
    }
    
    
}


extension ShowStartSearchController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.shows?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: ShowStartShowCell.self)
        cell.localShowStartModel = viewModel.shows?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 260
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = viewModel.shows?[indexPath.row].sequence
        let url = "https://wap.showstart.com/pages/activity/detail/detail?activityId=\(id!)"
        let webVC = XYSafariViewController(url: URL(string: url)!)
        
        self.navigationController?.pushViewController(webVC, animated: true)
        
    }
    
}

extension ShowStartSearchController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let text = "没有数据";
        let attributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: CGFloat(18.0)), NSAttributedString.Key.foregroundColor: UIColor.blue]
        return NSAttributedString(string: text, attributes: attributes)
    }
}

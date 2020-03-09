//
//  ShowStartViewController.swift
//  MyFirstApp
//
//  Created by 张啸宇 on 2020/1/14.
//  Copyright © 2020 xiaoyuu. All rights reserved.
//

import UIKit
import MJRefresh
import CoreLocation
import FSPagerView
import Then

class ShowStartViewController: XYBaseViewController {
    
    let locationManager = CLLocationManager()
    
    lazy var baiduMapViewModel =  BaiduMapViewModel()
    
    lazy var viewModel  = XYShowStartViewModel()
    
    
    
    open var city: ShowStartCityModel? {
        didSet {
            cityButton.setTitle(self.city?.cityName, for: .normal)
            self.tableView.uHead.beginRefreshing()
        }
    }
    
    private lazy var cityButton = UIButton(type: .system).then { (button) in
        button.frame = CGRect(x:0, y:0, width:65, height:30)
        button.setImage(R.image.location(), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.titleLabel?.font = .systemFont(ofSize: 11)
        button.titleLabel?.backgroundColor = .red
        button.setTitle("ddd", for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 3, left: -15, bottom: 3, right: 15)
//        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 10)

        button.addTarget(self, action: #selector(tappedCityButton), for: .touchUpInside)
    }
    
    @objc func tappedCityButton(){
        let vc = ShowStartCityController()
        vc.cityBlock = { [unowned self] city in
            self.city = city
            ShowStartCity = city
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }

   
    @objc func tappedVideoButton() {
        self.navigationController?.pushViewController(ShowStartVideoController(), animated: true)
    }
    
    private lazy var searchButton =  ShowStartSearchBarButton(frame: CGRect(x: 0, y: 0, width: ScreenWidth - 100, height: 30)).then {
        $0.addTarget(self, action: #selector(searchAction), for: .touchUpInside)
    }
    
    private lazy var tableView = UITableView(frame: SafeBounds, style: .plain).then {
        
        $0.backgroundColor = .white
        $0.delegate = self
        $0.dataSource = self
        $0.showsVerticalScrollIndicator = true
        
        $0.separatorStyle = .none
        
        $0.register(cellType: ShowStartShowCell.self)
        $0.uHead = URefreshHeader{[weak self] in self?.loadData(isHead: true)}
        $0.uFoot = URefreshAutoFooter{[weak self] in self?.loadData(isHead: false)}
    }
    
    private lazy var banner = FSPagerView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 100)).then {
        
        $0.transformer = FSPagerViewTransformer(type: .overlap)
        $0.interitemSpacing = 5
        $0.isInfinite = true
        $0.automaticSlidingInterval = 6.0
        $0.decelerationDistance = 3
        $0.itemSize = CGSize(width: 320, height: 150)
        
        $0.delegate = self
        $0.dataSource = self
        $0.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "bannerCell")
    }
    
    private lazy var bannerControl = FSPageControl(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 20)).then {
        $0.contentHorizontalAlignment = .right
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let dict = ["cityCode": ShowStartCity.cityCode, "cityName": ShowStartCity.cityName,"cityName_en":ShowStartCity.cityName_en]
        UserDefaults.standard.set(dict, forKey: Key.showStartzCityKey)
        UserDefaults.standard.synchronize()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.tableView)
        title = "首页"
        navigationItem.titleView = searchButton
        searchButton.snp.makeConstraints { (make) in
            make.width.equalTo(200)
            make.height.equalTo(30)
        }
        let videoBarItem = UIBarButtonItem(image: R.image.video()?.withTintColor(.gray), style: .plain, target: self, action: #selector(tappedVideoButton))
        let titleItem = UIBarButtonItem(title: "杭州", style: .plain, target: nil, action: nil)
        let cityBarItem = UIBarButtonItem(customView: cityButton)
        cityButton.snp.makeConstraints { (make) in
            make.width.equalTo(60)
            make.height.equalTo(30)
        }
        navigationItem.rightBarButtonItems = [videoBarItem, cityBarItem]
        
        locationManager.delegate = self
        //  onChangeLocationAuthorization()
        disableMyLocationBasedFeatures()
    
        self.city = ShowStartCity
        
    }
    
    
    func onChangeLocationAuthorization(){
        
        // MARK: compelete the location feature
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted, .denied:
            disableMyLocationBasedFeatures()
            break
        case .authorizedWhenInUse, .authorizedAlways:
            enableMyLocationBasedFeatures()
            break
        @unknown default:
            fatalError("Error")
        }
    }
    
    func disableMyLocationBasedFeatures() {
        let dict =  UserDefaults.standard.value(forKey: Key.showStartzCityKey) as? [String: String] ?? ["cityName": "杭州", "cityCode": "571", "cityName_en": "HANGZHOU"]
        ShowStartCity.cityCode = dict["cityCode"]
        ShowStartCity.cityName = dict["cityName"]
        ShowStartCity.cityName_en = dict["cityName_en"]
    }
    
    func enableMyLocationBasedFeatures() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.distanceFilter = 1.0
            locationManager.requestLocation()
            
            
            
        } else {
            disableMyLocationBasedFeatures()
        }
    }
    
    @objc func searchAction() {
        self.navigationController?.pushViewController(ShowStartSearchController(), animated: true)
    }
    
    func loadData(isHead: Bool) {
        viewModel.getBannersBlock = { [unowned self] in
            self.bannerControl.numberOfPages = self.viewModel.banners?.count ?? 0
            self.banner.reloadData()
        }
        
        viewModel.getShowListBlock = { [unowned self] in
            
            self.tableView.reloadData()
            if isHead {
                self.tableView.uHead.endRefreshing()
            } else {
                self.tableView.uFoot.endRefreshing()
            }
        }
        
        viewModel.getData(isReload: isHead)
    }
    
}
extension ShowStartViewController: FSPagerViewDelegate, FSPagerViewDataSource {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return viewModel.banners?.count ?? 0
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        bannerControl.currentPage = index
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "bannerCell", at: index)
        let banner = viewModel.banners?[index]
        cell.imageView?.kf.setImage(with: URL(string: banner?.poster ?? "https://s2.showstart.com/qn_8b60668d35d14777bc6e878428915014_1280_900_2015535.0x0.jpg"))
        cell.textLabel?.text = banner?.name
        cell.contentView.layer.cornerRadius = 15
        return cell
    }
    
    
}

extension ShowStartViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return self.viewModel.shows?.count ?? 0
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = XYBaseTableCell()
            cell.addSubview(banner)
            banner.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            cell.addSubview(bannerControl)
            bannerControl.snp.makeConstraints { make in
                make.left.equalToSuperview()
                make.height.equalTo(20)
                make.right.equalToSuperview().offset(-40)
                make.bottom.equalToSuperview().offset(-15)
            }
            return cell
            
        } else if indexPath.section == 1 {
            let cell  = tableView.dequeueReusableCell(for: indexPath) as ShowStartShowCell
            cell.localShowStartModel = viewModel.shows?[indexPath.row]
            return cell
        }else{
            let cell = XYBaseTableCell()
            let textLabel = UILabel(frame: CGRect(x: 20, y: 20, width: ScreenWidth-40, height: 20))
            textLabel.text = "没有更多演出了 ^_^"
            textLabel.textColor = .gray
            textLabel.font = .systemFont(ofSize: 12)
            textLabel.textAlignment = .center
            cell.addSubview(textLabel)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 180
        } else if indexPath.section == 1 {
            return 250
        } else {
            return 30
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let id = viewModel.shows?[indexPath.row].sequence
            let url = "https://wap.showstart.com/pages/activity/detail/detail?activityId=\(id!)"
            let webVC = XYSafariViewController(url: URL(string: url)!)
            
            self.navigationController?.pushViewController(webVC, animated: true)
            
        }
    }
}

extension ShowStartViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let coordinate = location.coordinate
            let string = "\(coordinate.latitude),\(coordinate.longitude)"
            baiduMapViewModel.updataBlock = {[unowned self] in
                self.disableMyLocationBasedFeatures()
                print(self.baiduMapViewModel.cityCode)
            }
            baiduMapViewModel.getData(location: string)
            
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("failed: \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        onChangeLocationAuthorization()
    }
}

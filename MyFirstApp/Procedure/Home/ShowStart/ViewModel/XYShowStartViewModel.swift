//
//  XYShowStartViewModel.swift
//  MyFirstApp
//
//  Created by 张啸宇 on 2020/1/23.
//  Copyright © 2020 xiaoyuu. All rights reserved.
//

import UIKit
import HandyJSON
import SwiftyJSON

class XYShowStartViewModel: NSObject {
    
    var getShowListBlock: XYBlock?
    var getBannersBlock: XYBlock?
    
    var banners: [ShowStartSiteModel]?
    var bannerSize = 6
    
    var shows : [XYShowStartDataModel]?
    var pageNo = 1
    var isLoadAllData = false
}

extension XYShowStartViewModel {
    func getData(isReload: Bool)  {
        let x = (isLoadAllData && !isReload)
        guard !x else {
            getShowListBlock?()
            return
        }
        
        if isReload {
            self.isLoadAllData = false
            self.pageNo = 1
            self.shows = [XYShowStartDataModel]()
            getBanner()
        }

        XYShowStartAPIProvider.request(.cityShowList(pageNo: pageNo)) {[weak self] (result) in
            if case let .success(response) = result {
                if let data = try? response.mapJSON(),let mappedObject = JSONDeserializer<XYShowStartModel>.deserializeFrom(json: JSON(data).description), let dataList = mappedObject.result?.dataList{
                    if dataList.count == 0 {
                        self?.isLoadAllData = true
                    } else {
                        self?.shows?.append(contentsOf: dataList)
                        self?.pageNo += 1
                    }
                    
                }
                self?.getShowListBlock?()
            }
        }
    }
    
    private func getBanner() {
        XYShowStartAPIProvider.request(.getBanner(size: bannerSize)) {[weak self] (result) in
            if case let .success(response) = result {
                if let data = try? response.mapJSON(), let mappedObject = JSONDeserializer<ShowStartBannerModel>.deserializeFrom(json: JSON(data).description), let dataList = mappedObject.result?.siteList {
                    self?.banners = dataList
                }
                self?.getBannersBlock?()
            }
        }
    }
}

//
//  ShowStartVideoViewModel.swift
//  MyFirstApp
//
//  Created by 张啸宇 on 2020/3/4.
//  Copyright © 2020 xiaoyuu. All rights reserved.
//

import Foundation
import HandyJSON
import SwiftyJSON

class ShowStartVideoViewModel: NSObject{
    var videoList = [ShowStartVideoModel]()
    var pageNo = 1
    var isLoadAllData = false
    
    var getVideoListBlock: XYBlock?
}

extension ShowStartVideoViewModel {
    
    func getData(isReload: Bool)  {
    
        if !isReload && isLoadAllData {
            getVideoListBlock?()
            return
        }
        
        if isReload {
            self.isLoadAllData = false
            self.pageNo = 1
            self.videoList = [ShowStartVideoModel]()
        }

        ShowStartAPIProvider.request(.videoList(pageNo: pageNo)) {[weak self] (result) in
            if case let .success(response) = result {
                if let data = try? response.mapJSON(),let dataList = JSONDeserializer<ShowStartResponseData<[ShowStartVideoModel]>>.deserializeFrom(json: JSON(data).description)?.result{
                    
                    if dataList.count == 0 {
                        self?.isLoadAllData = true
                    } else {
                        self?.videoList.append(contentsOf: dataList)
                        self?.pageNo += 1
                    }
                
                }
                self?.getVideoListBlock?()
            }
        }
    }
}

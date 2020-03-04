//
//  ShowStartSearchViewModel.swift
//  MyFirstApp
//
//  Created by 张啸宇 on 2020/2/12.
//  Copyright © 2020 xiaoyuu. All rights reserved.
//

import UIKit
import HandyJSON
import SwiftyJSON


class ShowStartSearchViewModel: NSObject {
    var updataBlock : XYAddDataBlock?
    typealias XYAddDataBlock = () -> Void
    
    var shows : [ShowStartShowModel]?
    var pageNo = 1
    var isLoadAllData = false
}

extension ShowStartSearchViewModel {
    
    func getData(keyword: String, isReload: Bool)  {
        
        if !isReload && isLoadAllData {
            self.updataBlock?()
            return
        }
        
        if isReload {
            self.isLoadAllData = false
            self.pageNo = 1
            self.shows = [ShowStartShowModel]()
        }
        
        ShowStartAPIProvider.request(.searchList(keyword: keyword, pageNo: pageNo)) { [weak self] (result) in
            if case let .success(response) = result {
                if let data = try? response.mapJSON(), let mappedObject = JSONDeserializer<ShowStartResponseData<ShowStartSearchModel>>.deserializeFrom(json: JSON(data).description),let dataList = mappedObject.result?.activityInfo {
                    if dataList.count == 0 {
                        self?.isLoadAllData = true
                    } else {
                        self?.shows?.append(contentsOf: dataList)
                        self?.pageNo += 1
                    }
                }
                self?.updataBlock?()
            }
        }
    }
      
}

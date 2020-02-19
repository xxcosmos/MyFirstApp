//
//  WUSTNoticeViewModel.swift
//  MyFirstApp
//
//  Created by 张啸宇 on 2020/1/31.
//  Copyright © 2020 xiaoyuu. All rights reserved.
//

import UIKit
import HandyJSON
import SwiftyJSON

class WUSTNoticeViewModel: NSObject {
    typealias XYAddDataBlock = () -> Void
    var updataBlock : XYAddDataBlock?
    var notices = [WUSTNoticeDataModel]()
    var pageNo = 1
    var isLoadAllData = false
}

extension WUSTNoticeViewModel {
    func getData(isReload: Bool,type: String)  {
        if isReload {
            self.isLoadAllData = false
            self.pageNo = 1
            self.notices = [WUSTNoticeDataModel]()
        } else {
            
            if isLoadAllData {
                self.updataBlock?()
                return
            }
        }
        
        WUSTAPIProvider.request(.getNoticeList(type: type, pageNo: pageNo)) {[weak self] (result) in
            if case let .success(response) = result {
                if let data = try? response.mapJSON(),let mappedObject = JSONDeserializer<WUSTNoticeModel>.deserializeFrom(json: JSON(data).description), let dataList = mappedObject.data{
                    if dataList.count == 0 {
                        self?.isLoadAllData = true
                    } else {
                        self?.notices.append(contentsOf: dataList)
                        self?.pageNo += 1
                    }
                    
                }
                self?.updataBlock?()
            }
        }
    }
}

//
//  WUSTNoticeModel.swift
//  MyFirstApp
//
//  Created by 张啸宇 on 2020/1/31.
//  Copyright © 2020 xiaoyuu. All rights reserved.
//

import Foundation
import HandyJSON


struct WUSTNoticeModel : HandyJSON {
    var result: Int?
    var msg: String?
    var navTabId: String?
    var callbackType: String?
    var pages: String?
    var pageNum: String?
    var count: String?
    var uid: String?
    var data: [WUSTNoticeDataModel]?
    
}

struct WUSTNoticeDataModel: HandyJSON {
    var id: Int?
    var title: String?
    var auther: String?
    var publishTime: String?
    var content: String?
    var url: String?
    var images : String?
    var type: String?
    
}

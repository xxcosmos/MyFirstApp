//
//  ShowStartBannerModel.swift
//  MyFirstApp
//
//  Created by 张啸宇 on 2020/2/15.
//  Copyright © 2020 xiaoyuu. All rights reserved.
//

import Foundation
import HandyJSON

struct ShowStartBannerModel : HandyJSON {
    var state : String?
    var isHasResult : String?
    var invalidParams : String?
    var msg : String?
    var result : ShowStartBannerResultModel?
    
}

struct ShowStartBannerResultModel: HandyJSON {
    var siteList: [ShowStartSiteModel]?
}

struct ShowStartSiteModel: HandyJSON {
    var address: String?
    var activityNum: Int?
    var cityCode: Int?
    var avatar: String?
    var cityName: String?
    var name: String?
    var poster: String?
}

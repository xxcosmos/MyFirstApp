//
//  ShowStartCityModel.swift
//  MyFirstApp
//
//  Created by 张啸宇 on 2020/2/12.
//  Copyright © 2020 xiaoyuu. All rights reserved.
//

import Foundation
import HandyJSON

struct ShowStartCityModel : HandyJSON {
    var state : String?
    var isHasResult : String?
    var invalidParams : String?
    var msg : String?
    var result : [ShowStartCityResultModel]?
}

struct ShowStartCityResultModel : HandyJSON {
    var title : String?
    var cityEntry : [ShowStartCityDataModel]?
}

struct ShowStartCityDataModel : HandyJSON {
    var cityName : String?
    var cityCode : String?
    var cityName_en : String?
    
}

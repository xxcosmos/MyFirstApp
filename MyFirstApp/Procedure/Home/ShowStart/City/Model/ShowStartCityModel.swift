//
//  ShowStartCityModel.swift
//  MyFirstApp
//
//  Created by 张啸宇 on 2020/2/12.
//  Copyright © 2020 xiaoyuu. All rights reserved.
//

import Foundation
import HandyJSON


struct ShowStartCityResultModel: HandyJSON {
    var title : String?
    var cityEntry : [ShowStartCityModel]?
}

struct ShowStartCityModel: HandyJSON {
    var cityName : String?
    var cityCode : String?
    var cityName_en : String?
}

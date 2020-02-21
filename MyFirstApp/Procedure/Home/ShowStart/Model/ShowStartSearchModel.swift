//
//  ShowStartSearchResultModel.swift
//  MyFirstApp
//
//  Created by 张啸宇 on 2020/2/12.
//  Copyright © 2020 xiaoyuu. All rights reserved.
//

import Foundation
import HandyJSON


struct ShowStartSearchModel: HandyJSON {
    var state : String?
    var isHasResult : String?
    var invalidParams : String?
    var msg : String?
    var result : ShowStartSearchResultModel?
    
}

struct ShowStartSearchResultModel: HandyJSON {
    var activityInfo: [XYShowStartDataModel]?
}

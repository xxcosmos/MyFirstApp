//
//  XYShowStartModel.swift
//  MyFirstApp
//
//  Created by 张啸宇 on 2020/1/23.
//  Copyright © 2020 xiaoyuu. All rights reserved.
//

import Foundation
import HandyJSON


struct ShowStartShowResultModel : HandyJSON {
    var title : String?
    var dataList : [ShowStartShowModel]?
}

struct ShowStartShowModel : HandyJSON {
    var activityId : String?
    var activityPrice : String?
    var activityType : Int?
    var activityTypeName : String?
    var address : String?
    var avatar : String?
    var canBringFriend : Int?
    var city : String?
    var friendRuleUrl : String?
    var groupId : Int?
    var isEnd : Int?
    var isShowCollection : Int?
    var isTour : Int?
    var leftDay : Int?
    var performerList : [String]?
    var performerName : String?
    var price : Int?
    var sellIdentity : Int?
    var sequence : Int?
    var showStartTime : Int?
    var showTime : String?
    var siteName : String?
    var styleIds : [Int]?
    var styles : [String]?
    var title : String?
    var week : String?
    var wishCount : Int?
}

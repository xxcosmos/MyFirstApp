//
//  ShowStartBaseModel.swift
//  MyFirstApp
//
//  Created by 张啸宇 on 2020/3/3.
//  Copyright © 2020 xiaoyuu. All rights reserved.
//

import Foundation
import HandyJSON

struct ShowStartResponseData<T: HandyJSON>: HandyJSON {
    var state: String?
    var isHasResult: String?
    var invalidParams: String?
    var msg: String?
    var result: T?
}

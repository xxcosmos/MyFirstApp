//
//  ShowStartCityViewModel.swift
//  MyFirstApp
//
//  Created by 张啸宇 on 2020/1/31.
//  Copyright © 2020 xiaoyuu. All rights reserved.
//

import UIKit
import HandyJSON
import SwiftyJSON

class ShowStartCityViewModel: NSObject {
    var getCityListBlock : XYAddDataBlock?
    typealias XYAddDataBlock = () -> Void

    var citys : [ShowStartCityResultModel]?
}

extension ShowStartCityViewModel {
    func refreshDataSource()  {
       
        XYShowStartAPIProvider.request(.cityList) { [weak self](result) in
            if case let .success(response) = result {
                if let data = try? response.mapJSON(),let mappedObject = JSONDeserializer<ShowStartCityModel>.deserializeFrom(json: JSON(data).description){
                        self?.citys = mappedObject.result
                }
                 self?.getCityListBlock?()
            }
        }
    }
    
}

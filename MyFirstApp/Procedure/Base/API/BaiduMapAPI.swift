//
//  BaiduMapAPI.swift
//  MyFirstApp
//
//  Created by 张啸宇 on 2020/2/13.
//  Copyright © 2020 xiaoyuu. All rights reserved.
//

import Foundation
import Moya
import HandyJSON
import SwiftyJSON

let BaiduMapAPIProvider = MoyaProvider<BaiduMapAPI>()
let BaiduAK = "dKgBhPwajTSkY5k4d97OQRx3fE9XPo0y"
let BaiduSK = "5PM4VT8O6IhG8hucWFLCuXwCM80WIbEL"
public enum BaiduMapAPI {
    case getCityByCoordinate(coordinate: String)
}

extension BaiduMapAPI: TargetType {
    
    public var baseURL: URL {
        return URL(string: "http://api.map.baidu.com")!
    }
    
    public var path: String {
        switch self {
        case .getCityByCoordinate:
            return "/reverse_geocoding/v3/"
            
        }
        
    }
    
    public var method: Moya.Method {
        return .get
    }
    
    
    public var task: Task {
        switch self {
        case .getCityByCoordinate(let location):
            let queryStr = "/reverse_geocoding/v3/?location=\(location)&output=json&ak=\(BaiduAK)\(BaiduSK)"
            let sn = queryStr.getMD5()
            let parameters = [
                "location": location,
                "output": "json",
                "ak": BaiduAK,
                "sn": sn ] as [String : Any]
            
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
            
            
        }
        
        
    }
    
    public var headers: [String : String]? {
        return nil
    }
    
    public var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
    
    
}

struct BaiduGeoModel: HandyJSON {
    var status: Int?
    var cityCode: Int?
}


class BaiduMapViewModel: NSObject {
    var updataBlock : XYAddDataBlock?
    typealias XYAddDataBlock = () -> Void
    
    var cityCode: Int?
    
}

extension BaiduMapViewModel {
    
    func getData(location: String)  {
        
        
        
        BaiduMapAPIProvider.request(.getCityByCoordinate(coordinate: location)) { [weak self] (result) in
            if case let .success(response) = result {
                if let data = try? response.mapJSON(), let mappedObject = JSONDeserializer<BaiduGeoModel>.deserializeFrom(json: JSON(data).description) {
                    print(mappedObject.toJSONString())
                    self?.cityCode = mappedObject.cityCode
                    
                }
                self?.updataBlock?()
            }
        }
    }
    
}

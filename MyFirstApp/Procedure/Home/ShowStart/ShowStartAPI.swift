//
//  XYShowStartAPI.swift
//  MyFirstApp
//
//  Created by 张啸宇 on 2020/1/20.
//  Copyright © 2020 xiaoyuu. All rights reserved.
//

import Foundation
import Moya

let ShowStartAPIProvider = MoyaProvider<ShowStartAPI>()
let appVersion = "4.5.2"

public enum ShowStartAPI {
    case cityShowList(pageNo: Int)
    case cityList
    case searchList(keyword: String, pageNo: Int)
    case getBanner(size: Int)
    case videoList(pageNo: Int)
}

extension ShowStartAPI: TargetType {
    
    public var baseURL: URL {
        return URL(string: "https://api.showstart.com")!
    }
    
    public var path: String {
        switch self {
        case .cityShowList:
            return "/app/activity/list.json"
            
        case .cityList:
            return "/app/city/group.json"
            
        case .searchList:
            return "/app/activity/search.json"
        case .getBanner:
            return "/app/home/discovery.json"
        case .videoList:
            return "/app/mmedia/localVideoList.json"
        }
        
    }
    
    public var method: Moya.Method {
        return .get
    }
    
    
    public var task: Task {
        switch self {
        case .videoList(let pageNo):
            let parameters = [
                "appVersion": appVersion,
                "pageNo": pageNo,
                "pageSize": 10
                ] as [String: Any]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
            
        case .cityShowList(let pageNo):
            let parameters = [
                "appVersion": appVersion,
                "cityId": ShowStartCity.cityCode!,
                "pageNo": pageNo,
                "pageSize": 10,
                "sortType": 1
                ] as [String : Any]
            
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
            
        case .cityList:
            let parameters = ["appVersion": appVersion]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
            
        case .searchList(let keyword,let pageNo):
            
            let parameters = [
                "appVersion": appVersion,
                "cityId": ShowStartCity.cityCode!,
                "keyword": keyword,
                "pageNo": pageNo,
                "pageSize": 10
                ] as [String : Any]
            
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .getBanner(let size):
            let parameters = [
                "appVersion": appVersion,
                "siteSize": size
                ] as [String : Any]
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

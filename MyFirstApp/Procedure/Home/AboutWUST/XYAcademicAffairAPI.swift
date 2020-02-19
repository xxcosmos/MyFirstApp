//
//  MyService.swift
//  MyFirstApp
//
//  Created by 张啸宇 on 2019/12/9.
//  Copyright © 2019 xiaoyuu. All rights reserved.
//

import Foundation
import Moya

let WUSTAPIProvider = MoyaProvider<WUSTAPI>()

public enum WUSTAPI {
    case getNoticeList(type: String, pageNo: Int)
}

extension WUSTAPI: TargetType {
    
    
    
    public var baseURL: URL {
        return URL(string: "http://app.wust.edu.cn")!
    }
    
    public var path: String {
        switch self {
        case .getNoticeList:
            return "/ydd/newsTz/apprJson"
            
            
        }
    }
    
    public var method: Moya.Method {
        return .get
    }
    
    
    public var task: Task {
        switch self {
        case .getNoticeList(let type, let pageNo):
            let parameters = [
                "type": type,
                "page": pageNo
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


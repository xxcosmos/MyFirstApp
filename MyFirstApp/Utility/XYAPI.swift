//
//  MyService.swift
//  MyFirstApp
//
//  Created by 张啸宇 on 2019/12/9.
//  Copyright © 2019 xiaoyuu. All rights reserved.
//

import Foundation
import Moya

enum XYAPI {
    case loginToWustWireless(username: String, password: String)
    
}

extension XYAPI: TargetType {
    
    var baseURL: URL {return URL(string: "http://10.200.2.2:9090")!}
    
    var path: String {
        switch self {
        case .loginToWustWireless:return "zportal/login/do"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .loginToWustWireless:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .loginToWustWireless(let username, let password):
            let data = [
                      "username" : username,
                      "pwd" : password,
                      "wlanuserip" : "f09df0ee06255f08c28797b2f2383ef8",
                      "nasip" : "5340d13e4208e1b891476c890b7f5f5c"
                  ]
            return .requestParameters(parameters:data, encoding: URLEncoding.default)
            
        }
    }
    
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    var headers: [String: String]? {
        switch self {
        case .loginToWustWireless: return ["Content-Type" : "application/x-www-form-urlencoded"]
       
        }
    }
    
}

//
//  JwcAPI.swift
//  MyFirstApp
//
//  Created by 张啸宇 on 2020/2/21.
//  Copyright © 2020 xiaoyuu. All rights reserved.
//


import Foundation
import Moya

let JwcAPIProvider = MoyaProvider<JwcAPI>()

public enum JwcAPI {
    case getStudentGrade(studentId: String)
}

extension JwcAPI: TargetType {
    
    public var baseURL: URL {
        return URL(string: "http://jwxt.wust.edu.cn")!
    }
    
    public var path: String {
        return "/whkjdx/services/whkdapp"
    }
    
    public var method: Moya.Method {
        return .post
    }
    
    
    public var task: Task {
        switch self {
        case .getStudentGrade(let id):
            let data = """
<v:Envelope xmlns:i="http://www.w3.org/2001/XMLSchema-instance" xmlns:d="http://www.w3.org/2001/XMLSchema" xmlns:c="http://schemas.xmlsoap.org/soap/encoding/" xmlns:v="http://schemas.xmlsoap.org/soap/envelope/">
    <v:Header />
    <v:Body>
        <getxscj xmlns="http://webservices.qzdatasoft.com" id="o0" c:root="1">
            <in0 i:type="d:string">\(id)</in0>
            <in1 i:type="d:string">2019-05-03 01:04:42</in1>
            <in2 i:type="d:string">c61a4c8cc546056465c54d70a891f6</in2>
        </getxscj>
    </v:Body>
</v:Envelope>
"""
            return .requestData(data.data(using: .utf8)!)
            
        }
    }
    
    public var headers: [String : String]? {
        return [
            "Content-Type":"text/xml"
            ]
    }
    
    public var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
    
}



//
//  DepartmentNoticeAPI.swift
//  snuboard
//
//  Created by Subeen Park on 2021/09/08.
//

import Foundation
import Moya

enum DepartmentNoticeAPI {
    case createNewUser(token: String)
}


extension DepartmentNoticeAPI: TargetType {
    var baseURL: URL {
        guard let url = URL(string: BaseAPI.baseURL) else {
            fatalError()
        }
        return url
    }
    
    var path: String {
        switch self {
        case .createNewUser:
            return "/users/"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .createNewUser:
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .createNewUser(let token):
            return .requestParameters(parameters: ["token": token], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    
}

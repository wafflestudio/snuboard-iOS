//
//  AuthAPI.swift
//  snuboard
//
//  Created by Subeen Park on 2021/08/31.
//

import Foundation
import Moya
import RxSwift

enum AuthAPI {
    case createNewUser(token: String)
}


extension AuthAPI: TargetType {
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


// Moya 401 Refresh: https://gist.github.com/susemi99/841b2c3935b2028b2162842d479de143


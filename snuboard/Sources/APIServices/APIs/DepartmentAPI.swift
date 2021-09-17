//
//  DepartmentAPI.swift
//  snuboard
//
//  Created by Subeen Park on 2021/09/08.
//

import Foundation
import Moya


enum DepartmentAPI {
    case getAllDepartments
    case getDepartmentById(id: Int)
    case createDepartmentFollow(id: Int, follow: String)
    case deleteDepartmentFollow(id: Int, follow: String)
}


extension DepartmentAPI: TargetType {
    var baseURL: URL {
        guard let url = URL(string: BaseAPI.baseURL) else {
            fatalError()
        }
        return url
    }
    
    var path: String {
        switch self {
        case .getAllDepartments:
            return "/departments/"
        case .getDepartmentById(let id):
            return "/departments/\(id)"
        case .createDepartmentFollow(let id, _):
            return "/departments/\(id)/follow"
        case .deleteDepartmentFollow(let id, _):
            return "/departments/\(id)/follow"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getAllDepartments:
            return .get
        case .getDepartmentById:
            return .get
        case .createDepartmentFollow:
            return .post
        case .deleteDepartmentFollow:
            return .delete
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getAllDepartments:
            return .requestPlain
        case .getDepartmentById:
            return .requestPlain
        case .createDepartmentFollow(_ , let follow):
            return .requestParameters(parameters: ["follow": follow], encoding: JSONEncoding.default)
        case .deleteDepartmentFollow(_ , let follow):
            return .requestParameters(parameters: ["follow": follow], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json",
                "Authorization": TokenUtils.getAccessTokenHeader()!]
        
    }
    
    
}




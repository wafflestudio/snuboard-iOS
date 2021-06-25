//
//  DepartmentsAPI.swift
//  snuboard
//
//  Created by Subeen Park on 2021/06/20.
//

import Foundation
import Alamofire

enum DepartmentsAPI: BaseAPI {
    
    static var baseURL: String = "https://snuboard-api.wafflestudio.com/departments/"
    
    
    
    var accessTokenNeeded: Bool {
        return true
    }
    
    var refreshTokenNeeded: Bool {
        return false
    }
    
    var method: HTTPMethod {
        switch self {
        case .getAllDepartments:
            return .get
        case .createDepartmentFollow:
            return .post
        case .deleteDepartmentFollow:
            return .delete
        default:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getAllDepartments:
            return ""
        case .createDepartmentFollow(let id, _):
            return "/\(id)/follow"
        case .deleteDepartmentFollow(let id, _):
            return "/\(id)/follow"
        default:
            return ""
        }
    }
    
    var param: [String : Any]? {
        switch self {
        
        case .createDepartmentFollow(_, let follow):
            return ["follow": follow]
            
        case .deleteDepartmentFollow(_, let follow):
            return ["follow": follow]
    
        
        default:
            return nil
        }
        
        
    }
    
    
    case getAllDepartments
    case createDepartmentFollow(id: Int, follow: String)
    case deleteDepartmentFollow(id: Int, follow: String)
    
    
    
}

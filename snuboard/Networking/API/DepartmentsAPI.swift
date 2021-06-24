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
        default:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getAllDepartments:
            return ""
        
        default:
            return ""
        }
    }
    
    var param: [String : Any]? {
        switch self {
    
        
        default:
            return nil
        }
        
        
    }
    
    
    case getAllDepartments
    
    
}

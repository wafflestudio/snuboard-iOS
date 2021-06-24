//
//  UserAPI.swift
//  snuboard
//
//  Created by Subeen Park on 2021/06/20.
//

import Foundation
import Alamofire

enum UserAPI: BaseAPI {

    
    
    static var baseURL: String = "https://snuboard-api.wafflestudio.com/users/"
    
    var accessTokenNeeded: Bool {
        switch self {
        case .createNewUser:
            return false
        case .authorizeUser:
            return false
        default:
            return true
        }
        
    }
    
    var refreshTokenNeeded: Bool {
        switch self {
        case .createNewUser:
            return false
        case .authorizeUser(let grantType, _, _):
            if grantType == "refresh_token" {
                return true
            } else {
                return false
            }
        default:
            return false
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .createNewUser:
            return .post
        case .authorizeUser:
            return .post
        default:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .createNewUser:
            return ""
        case .authorizeUser:
            return "auth/token/"
        default:
            return ""
        }
    }
    
    var param: [String : Any]? {
        switch self {
        case .createNewUser(let username, let password, let email):
            return ["username" : username,
                    "password" : password,
                    "nickname" : email]
        case .authorizeUser(let grantType, let username, let password):
            if grantType == "refresh_token" {
                return ["grant_type" : grantType]
            } else {
                return ["grant_type" : grantType,
                        "username" : username,
                        "password": password]
            }
        default:
            return nil
        }
        
        
    }
    
    
    
    
    case createNewUser(username: String, password: String, email: String)
    case authorizeUser(grantType: String, username: String?, password: String?)

    
}

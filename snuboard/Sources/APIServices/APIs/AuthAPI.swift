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
    case refreshToken
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
        case .refreshToken:
            return "/users/auth/token/"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .createNewUser:
            return .post
        case .refreshToken:
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
        case .refreshToken:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .createNewUser:
            return ["Content-Type": "application/json"]
        case .refreshToken:
            return ["Content-Type": "application/json",
                    "Authorization": TokenUtils.getRefreshTokenHeader()!]
        }
        
    }
    
    
}

/// 인증 관련 API
final class AuthService: BaseService<AuthAPI> {
  static let shared = AuthService()
  private override init() {}

  /// 토큰 재발급
  func refreshToken() -> Single<Response> {
    return request(.refreshToken)
  }
}



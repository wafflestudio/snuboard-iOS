//
//  APIConstants.swift
//  snuboard
//
//  Created by Subeen Park on 2021/06/20.
//

import Foundation
import Alamofire

protocol BaseAPI {
    
    static var baseURL: String { get }
    var accessTokenNeeded: Bool { get }
    var refreshTokenNeeded: Bool { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var param: [String: Any]? { get }
    
}


extension BaseAPI {
    
    func requestAPI() -> DataRequest {
        
        let URL = Self.baseURL + path
        
        var header: HTTPHeaders = ["Content-Type": "application/json"]
        
        if accessTokenNeeded {
            header["Authorization"] = TokenUtils.getAccessTokenHeader()
            
        }
        
        if refreshTokenNeeded {
            header["Authorization"] = TokenUtils.getRefreshTokenHeader()
            
        }
        
        return AF.request(URL,
                          method: method,
                          parameters: param,
                          encoding: JSONEncoding.default,
                          headers: header
                          )
        
    }
    
    
}

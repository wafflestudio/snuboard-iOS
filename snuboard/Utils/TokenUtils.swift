//
//  TokenUtils.swift
//  snuboard
//
//  Created by Subeen Park on 2021/06/20.
//
// Reference: https://github.com/coinbase/coinbase-ios-sdk/blob/master/Example/Source/Utils/TokenUtils.swift
//  Copyright © 2018 Coinbase All rights reserved.


import Foundation
import Alamofire

public struct TokenUtils {
    
    private static let accessTokenKey = "accessTokenKey"
    private static let refreshTokenKey = "refreshTokenKey"
    private static let id = "id"
    private static let password = "password"
    
    public static func enabeleAutoLogin(id: String?, password: String?) {
        storeID(id)
        storePW(password)
    }
    
    public static func store(accessToken: String?, refreshToken: String?) {
        storeAccessToken(accessToken)
        storeRefreshToken(refreshToken)
    }
    
    public static func storeID(_ id: String?) {
        KeychainService.save(string: id, for: self.id)
    }
    
    public static func storePW(_ password: String?) {
        KeychainService.save(string: password, for: self.password)
    }
    
    public static func storeAccessToken(_ token: String?) {
        KeychainService.save(string: token, for: accessTokenKey)
    }
    
    public static func storeRefreshToken(_ token: String?) {
        KeychainService.save(string: token, for: refreshTokenKey)
    }
    
    public static func loadAccessToken() -> String? {
        return KeychainService.loadString(for: accessTokenKey)
    }
    
    public static func loadRefreshToken() -> String? {
        return KeychainService.loadString(for: refreshTokenKey)
    }
    
    public static func loadID() -> String? {
        return KeychainService.loadString(for: id)
    }
    
    public static func loadPW() -> String? {
        return KeychainService.loadString(for: password)
    }
    
    public static func getAccessTokenHeader() -> String? {
        return "Bearer \(String(describing: loadAccessToken()!))"
    }
    
    public static func getRefreshTokenHeader() -> String? {
        return "Bearer \(String(describing: loadRefreshToken()!))"
    }
  
}


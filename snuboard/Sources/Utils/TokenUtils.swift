//
//  TokenUtils.swift
//  snuboard
//
//  Created by Subeen Park on 2021/09/03.
// Reference: https://github.com/coinbase/coinbase-ios-sdk/blob/master/Example/Source/Utils/TokenUtils.swift
//  Copyright © 2018 Coinbase All rights reserved.


import SwiftUI

public struct TokenUtils {
    
    private static var accessTokenKey = "accessTokenKey"
    private static var refreshTokenKey = "refreshTokenKey"
    private static var fcmToken = "FCMtoken"
    let defaults = UserDefaults.standard
    
    public static func storeTokens(accessToken: String?, refreshToken: String?) {
        storeAccessToken(accessToken)
        storeRefreshToken(refreshToken)
    }
    
    public static func storeFCMtoken(_ token: String?) {
//        KeychainService.save(string: token, for: self.fcmToken)
        UserDefaults.standard.set(token, forKey: self.fcmToken)
    }
    
    public static func storeAccessToken(_ token: String?) {
//        KeychainService.save(string: token, for: accessTokenKey)
        UserDefaults.standard.set(token, forKey: self.accessTokenKey)
    }
    
    public static func storeRefreshToken(_ token: String?) {
//        KeychainService.save(string: token, for: refreshTokenKey)
        UserDefaults.standard.set(token, forKey: self.refreshTokenKey)
    }
    
    public static func loadAccessToken() -> String? {
//        return KeychainService.loadString(for: accessTokenKey)
        return UserDefaults.standard.string(forKey: self.accessTokenKey)
    }
    
    public static func loadRefreshToken() -> String? {
//        return KeychainService.loadString(for: refreshTokenKey)
        return UserDefaults.standard.string(forKey: self.refreshTokenKey)
    }
    
    public static func loadFCMtoken() -> String? {
//        return KeychainService.loadString(for: fcmToken)
        return UserDefaults.standard.string(forKey: self.fcmToken)
    }
    
    public static func getAccessTokenHeader() -> String? {
        return "Bearer \(String(describing: loadAccessToken()!))"
    }
    
    public static func getRefreshTokenHeader() -> String? {
        return "Bearer \(String(describing: loadRefreshToken()!))"
    }
  
}



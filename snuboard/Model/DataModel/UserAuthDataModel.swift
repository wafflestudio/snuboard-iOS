//
//  UserAuthDataModel.swift
//  snuboard
//
//  Created by Subeen Park on 2021/06/20.
//

import Foundation

// For /users/,/users/auth/token/,
// MARK: - UserCreateDataModel
struct UserAuthDataModel: Codable {
    let id: Int
    let username, nickname, accessToken, refreshToken: String
    let keywords: [String]

    enum CodingKeys: String, CodingKey {
        case id, username, nickname
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case keywords
    }
    
    public func saveUserAuthDataModel() {
        
        UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
        UserDefaults.standard.synchronize()
        UserDefaults.standard.setValue(self.nickname, forKey: "nickname")
        UserDefaults.standard.setValue(self.username, forKey: "username")
        TokenUtils.storeAccessToken(self.accessToken)
        TokenUtils.storeRefreshToken(self.refreshToken)
    }
}



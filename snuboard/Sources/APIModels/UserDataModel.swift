//
//  UserDataModel.swift
//  snuboard
//
//  Created by Subeen Park on 2021/08/31.
//

import Foundation

struct UserDataModel: Codable {
    let id: Int
    let accessToken, refreshToken: String

    enum CodingKeys: String, CodingKey {
        case id
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
    }
    
    public func saveUserAuthDataModel() {
        
        UserDefaults.standard.set(true, forKey: "isUserSignedUp")
        UserDefaults.standard.synchronize()
        TokenUtils.storeAccessToken(self.accessToken)
        TokenUtils.storeRefreshToken(self.refreshToken)

    }
    
}


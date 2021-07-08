//
//  SignInViewModel.swift
//  snuboard
//
//  Created by Subeen Park on 2021/06/21.
//

import Foundation


class SignInViewModel: ObservableObject {
    
    @Published var username: String = ""
    @Published var password: String = ""
    
    @Published var pushActive = false
    
    func signIn() {
        StartAppService.shared.signIn(username: username, password: password) { response in

                switch response {
                case .success(let userAuthData):
                    if let data = userAuthData as? UserAuthDataModel {
                        data.saveUserAuthDataModel()
                        TokenUtils.storeID(self.username)
                        TokenUtils.storePW(self.password)
                        print("Sign In Success")
                        self.pushActive = true
            
                    }
                case .badRequest(let badRequestData):
                    print("badRequest", badRequestData)
                    
                case .pathError :
                    print("pathERR")
                case .serverError:
                    print("serverERR")
                case .networkFailure:
                    print("networkFail")
                case .unauthorized:
                    print("unauthorized")
                default:
                    print("default")
                }
    
       }
    }
    
    
    
}

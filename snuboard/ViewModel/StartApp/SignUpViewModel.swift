//
//  SignUpViewModel.swift
//  snuboard
//
//  Created by Subeen Park on 2021/06/20.
//

import Foundation


class SignUpViewModel: ObservableObject {
    
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var email: String = ""
    
    @Published var pushActive = false
    
    func signUp() {
        StartAppService.shared.signUp(username: username, password: password, email: email) { response in

                switch response {
                case .success(let userAuthData):
                    if let data = userAuthData as? UserAuthDataModel {
                        data.saveUserAuthDataModel()
                        TokenUtils.storeID(self.username)
                        TokenUtils.storePW(self.password)
                        print("Sign Up Success")
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

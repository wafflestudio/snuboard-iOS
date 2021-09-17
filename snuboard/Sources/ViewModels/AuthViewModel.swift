//
//  AuthViewModel.swift
//  snuboard
//
//  Created by Subeen Park on 2021/09/03.
//

import Moya

class AuthViewModel: ObservableObject {

    @Published var pushActive = false
    private lazy var service = MoyaProvider<AuthAPI>()
    
    func signUp() {
        
        print("signUp")
        
        guard let token = TokenUtils.loadFCMtoken() else { return
            print("noFCMToken")
        }

        service.request(AuthAPI.createNewUser(token: token)) { result in
            switch result {
            case .success(let response):
                print(response.statusCode)
                do {
                    let filteredResponse = try response.filter(statusCodes: 200...299)
                    let response = try JSONDecoder().decode(UserDataModel.self, from: filteredResponse.data)
                    print(response)
                    response.saveUserAuthDataModel()
                    self.pushActive = true
                    print("self.pushActive \(self.pushActive)")
                } catch let err {
                    print(err.localizedDescription)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }

    }
    
    
}

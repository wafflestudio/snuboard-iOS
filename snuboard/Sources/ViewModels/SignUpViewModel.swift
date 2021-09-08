//
//  SignUpViewModel.swift
//  snuboard
//
//  Created by Subeen Park on 2021/09/03.
//

import Moya

class SignUpViewModel: ObservableObject {

    @Published var pushActive = false
    private lazy var service = MoyaProvider<AuthAPI>()
    
    func signUp(toggleLoading: @escaping ()->(), completion: @escaping ()->()) {
        guard let token = TokenUtils.loadFCMtoken() else { return }
        toggleLoading()
        service.request(AuthAPI.createNewUser(token: token)) { result in
            switch result {
            case .success(let response):
                print(response.statusCode)
                do {
                    let filteredResponse = try response.filter(statusCodes: 200...299)
                    let response = try JSONDecoder().decode(UserDataModel.self, from: filteredResponse.data)
                    response.saveUserAuthDataModel()
                    self.pushActive = true
                    completion()
                    print(self.pushActive)
                } catch let err {
                    print(err.localizedDescription)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        toggleLoading()
    }
    
    
}

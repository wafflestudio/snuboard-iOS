//
//  StartAppService.swift
//  snuboard
//
//  Created by Subeen Park on 2021/06/20.
//


import Foundation
import Alamofire

struct StartAppService {
    
    static let shared = StartAppService()
    
    func signUp(username: String, password: String, email: String, completion: @escaping (NetworkResult<UserAuthDataModel>) -> ()) {
        
        let dataRequest = UserAPI.createNewUser(username: username, password: password, email: email).requestAPI()
        
        
        dataRequest.responseData { dataResponse in

            switch dataResponse.result {

            // success status code
            case .success:
                guard let statusCode = dataResponse.response?.statusCode
                else {return}
                print(statusCode)
                guard let value = dataResponse.value else {return}
                print(value)
                let networkResult: NetworkResult<UserAuthDataModel> = NetworkResult<Any>.judgeStatus(by: statusCode, data: value)
                completion(networkResult)

            // faiulure status code
            case .failure: completion(.pathError)


            }

        }
        
    }
        
    
    func signIn(username: String, password: String, completion: @escaping (NetworkResult<UserAuthDataModel>) -> ()) {
        
        let dataRequest = UserAPI.authorizeUser(grantType: "password", username: username, password: password).requestAPI()
        
        
        dataRequest.responseData { dataResponse in

            switch dataResponse.result {

            // success status code
            case .success:
                guard let statusCode = dataResponse.response?.statusCode
                else {return}
                print(statusCode)
                guard let value = dataResponse.value else {return}
                print(value)
                let networkResult : NetworkResult<UserAuthDataModel> = NetworkResult<Any>.judgeStatus(by: statusCode, data: value)
                completion(networkResult)

            // faiulure status code
            case .failure: completion(.pathError)


            }

        }
    
    
    }
    
}


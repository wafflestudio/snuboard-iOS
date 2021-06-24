//
//  DepartmentsService.swift
//  snuboard
//
//  Created by Subeen Park on 2021/06/20.
//

import Foundation
import Alamofire


struct DepartmentService {
    
    static let shared = DepartmentService()
    
    public func getAllDepartments(completion: @escaping (NetworkResult<[Department]>) -> ()) {
        
        let dataRequest = DepartmentsAPI.getAllDepartments.requestAPI()
        
        dataRequest.responseData { dataResponse in
            
            switch dataResponse.result {

            // success status code
            case .success:
                guard let statusCode = dataResponse.response?.statusCode
                else {return}
                print(statusCode)
                guard let value = dataResponse.value else {return}
                print(value)
                
                let networkResult: NetworkResult<[Department]> = NetworkResult<Any>.judgeStatus(by: statusCode, data: value)

                completion(networkResult)

            // faiulure status code
            case .failure: completion(.pathError)


            }
            
        }

    
    
    }
    
    
   
}



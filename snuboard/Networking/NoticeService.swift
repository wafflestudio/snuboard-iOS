//
//  NoticeService.swift
//  snuboard
//
//  Created by Subeen Park on 2021/06/25.
//


import Foundation
import Alamofire


struct NoticeService {
    
    static let shared = NoticeService()
    
    public func getNoticesByDepartmentId(id: Int, completion: @escaping (NetworkResult<NoticeSummaryListDataModel>) -> ()) {
        
        let dataRequest = NoticeAPI.getNoticesByDepartmentId(id: id).requestAPI()
        
        dataRequest.responseData { dataResponse in
            
            switch dataResponse.result {

            // success status code
            case .success:
                guard let statusCode = dataResponse.response?.statusCode
                else {return}
                print(statusCode)
                guard let value = dataResponse.value else {return}
                print(value)
                
                let networkResult: NetworkResult<NoticeSummaryListDataModel> = NetworkResult<Any>.judgeStatus(by: statusCode, data: value)

                completion(networkResult)

            // faiulure status code
            case .failure: completion(.pathError)


            }
            
        }

    
    } // end of getNoticesByDepartmentId
    
    
   
}



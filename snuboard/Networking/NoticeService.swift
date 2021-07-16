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
    
    public func getNoticesByDepartmentId(id: Int, tags: [String]=[], completion: @escaping (NetworkResult<NoticeSummaryListDataModel>) -> ()) {
        
        let dataRequest = NoticeAPI.getNoticesByDepartmentId(id: id, tags: tags).requestAPI()
        
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
    
    public func getNoticesByFollow(completion: @escaping (NetworkResult<NoticeSummaryListDataModel>) -> ()) {
        
        let dataRequest = NoticeAPI.getNoticesByFollow.requestAPI()
        
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

    
    }
    
    
    public func getScrappedNotices(completion: @escaping (NetworkResult<NoticeSummaryListDataModel>) -> ()) {
        
        let dataRequest = NoticeAPI.getScrappedNotices.requestAPI()
        
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

    
    }
    
    
    public func postNoticeScrap(id: Int, completion: @escaping (NetworkResult<NoticeDetail>) -> ()) {
    
        let dataRequest = NoticeAPI.postNoticeScrap(id: id).requestAPI()
        
        dataRequest.responseData { dataResponse in
            
            switch dataResponse.result {

            // success status code
            case .success:
                guard let statusCode = dataResponse.response?.statusCode
                else {return}
                print(statusCode)
                guard let value = dataResponse.value else {return}
                print(value)
                
                let networkResult: NetworkResult<NoticeDetail> = NetworkResult<Any>.judgeStatus(by: statusCode, data: value)

                completion(networkResult)

            // faiulure status code
            case .failure: completion(.pathError)


            }
            
        }
        
    }
    
    public func deleteNoticeScrap(id: Int, completion: @escaping (NetworkResult<NoticeDetail>) -> ()) {
    
        let dataRequest = NoticeAPI.deleteNoticeScrap(id: id).requestAPI()
        
        dataRequest.responseData { dataResponse in
            
            switch dataResponse.result {

            // success status code
            case .success:
                guard let statusCode = dataResponse.response?.statusCode
                else {return}
                print(statusCode)
                guard let value = dataResponse.value else {return}
                print(value)
                
                let networkResult: NetworkResult<NoticeDetail> = NetworkResult<Any>.judgeStatus(by: statusCode, data: value)

                completion(networkResult)

            // faiulure status code
            case .failure: completion(.pathError)


            }
            
        }
        
    }
    
    public func getNoticeByNoticeId(id: Int, completion: @escaping (NetworkResult<NoticeDetail>) -> ()) {
    
        let dataRequest = NoticeAPI.getNoticeByNoticeId(id: id).requestAPI()
        
        dataRequest.responseData { dataResponse in
            
            switch dataResponse.result {

            // success status code
            case .success:
                guard let statusCode = dataResponse.response?.statusCode
                else {return}
                print(statusCode)
                guard let value = dataResponse.value else {return}
                print(value)
                
                let networkResult: NetworkResult<NoticeDetail> = NetworkResult<Any>.judgeStatus(by: statusCode, data: value)

                completion(networkResult)

            // faiulure status code
            case .failure: completion(.pathError)


            }
            
        }
        
    }
    
    public func searchNoticeByFollowingTags(keywords: String, completion: @escaping (NetworkResult<NoticeSummaryListDataModel>) -> ()) {
    
        let dataRequest = NoticeAPI.searchNoticesByFollowingTags(keywords: keywords).requestAPI() 
        
        dataRequest.responseData { dataResponse in
            
            print(dataRequest)
            
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
        
    }
    
    public func searchNoticeWithDepartmentId(id: Int, tags: [String], keywords: String, completion: @escaping (NetworkResult<NoticeSummaryListDataModel>) -> ()) {
    
        let dataRequest = NoticeAPI.searchNoticesWithDepartmentId(id: id, tags: tags, keywords: keywords).requestAPI()
        
        dataRequest.responseData { dataResponse in
            
            print(dataRequest)
            
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
        
    }
    
   
}



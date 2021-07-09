//
//  NoticeAPI.swift
//  snuboard
//
//  Created by Subeen Park on 2021/06/25.
//


import Foundation
import Alamofire

enum NoticeAPI: BaseAPI {
    
    static var baseURL: String = "https://snuboard-api.wafflestudio.com/notices/"

    
    var accessTokenNeeded: Bool {
        return true
    }
    
    var refreshTokenNeeded: Bool {
        return false
    }
    
    var method: HTTPMethod {
        switch self {
        case .getNoticesByDepartmentId:
            return .get
        case .getScrappedNotices:
            return .get
        case .postNoticeScrap:
            return .post
        case .deleteNoticeScrap:
            return .delete
        case .getNoticeByNoticeId:
            return .get
        default:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getNoticesByDepartmentId(let id):
            return "department/\(id)"
        case .getScrappedNotices:
            return "scrap"
        case .postNoticeScrap(let id):
            return "\(id)/scrap"
        case .deleteNoticeScrap(let id):
            return "\(id)/scrap"
        case .getNoticeByNoticeId(let id):
            return "\(id)"
            
        default:
            return ""
        }
    }
    
    var param: [String : Any]? {
        switch self {
        
        case .getNoticesByDepartmentId:
            return ["limit": 30]
        case .getScrappedNotices:
            return ["limit": 30]
    
        
        default:
            return nil
        }
        
        
    }
    
    
    case getNoticesByDepartmentId(id: Int)
    case getScrappedNotices
    case postNoticeScrap(id: Int)
    case deleteNoticeScrap(id: Int)
    case getNoticeByNoticeId(id: Int)
    
    
    
    func requestAPI() -> DataRequest {
        
        let URL = Self.baseURL + path
        
        var header: HTTPHeaders = ["Content-Type": "application/json"]
        
        if accessTokenNeeded {
            header["Authorization"] = TokenUtils.getAccessTokenHeader()
            
        }
        
        if refreshTokenNeeded {
            header["Authorization"] = TokenUtils.getRefreshTokenHeader()
            
        }
        

        return AF.request(URL,
                          method: method,
                          parameters: param,
                          encoding: URLEncoding.queryString,
                          headers: header
                          )
        
    }
    
    
    
}

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
        case .getNoticesByFollow:
            return .get
        case .getScrappedNotices:
            return .get
        case .postNoticeScrap:
            return .post
        case .deleteNoticeScrap:
            return .delete
        case .getNoticeByNoticeId:
            return .get
        case .searchNoticesByFollowingTags:
            return .get
        default:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getNoticesByDepartmentId(let id, _):
            return "department/\(id)"
        case .getNoticesByFollow:
            return "follow"
        case .getScrappedNotices:
            return "scrap"
        case .postNoticeScrap(let id):
            return "\(id)/scrap"
        case .deleteNoticeScrap(let id):
            return "\(id)/scrap"
        case .getNoticeByNoticeId(let id):
            return "\(id)"
        case .searchNoticesByFollowingTags:
            return "follow/search"
        }
    }
    
    var param: [String : Any]? {
        switch self {
        
        case .getNoticesByFollow:
            return ["limit": 30]
        case .getNoticesByDepartmentId( _, let tags):
            if tags.isEmpty {
                return ["limit": 30]
            } else {
                return ["limit":30,
                        "tags": tags.joined(separator: ",")]
            }
        case .getScrappedNotices:
            return ["limit": 30]
        case .searchNoticesByFollowingTags(let keywords):
            return ["keywords" : keywords,
                    "limit": 30,
                    "content" : "true",
                    "title": "true"]
    
        
        default:
            return nil
        }
        
        
    }
    
    
    case getNoticesByDepartmentId(id: Int, tags: [String])
    case getNoticesByFollow
    case getScrappedNotices
    case postNoticeScrap(id: Int)
    case deleteNoticeScrap(id: Int)
    case getNoticeByNoticeId(id: Int)
    case searchNoticesByFollowingTags(keywords: String)
    
    
    
    
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

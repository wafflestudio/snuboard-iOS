//
//  NoticeAPI.swift
//  snuboard
//
//  Created by Subeen Park on 2021/09/10.
//

import Foundation
import Moya



enum NoticeAPI {
    
    case getNoticesByDepartmentId(id: Int, cursor: String?, tags: String)
    case searchNoticesWithDepartmentId(id: Int, cursor: String?, tags: String, keywords: String)
    case getNoticesByFollow(cursor: String?)
    case searchNoticesWithFollow(cursor: String?, keywords: String)
    case getScrappedNotices(cursor: String?)
    case getNoticeById(id: Int)
    case deleteNoticeScrap(id: Int)
    case createNoticeScrap(id: Int)
    
}


extension NoticeAPI: TargetType {
    
    var baseURL: URL {
        guard let url = URL(string: BaseAPI.baseURL) else {
            fatalError()
        }
        return url
    }
    
    var path: String {
        
        switch self {
        case .getNoticesByDepartmentId(let id, _, _):
            return "/notices/department/\(id)"
        case .searchNoticesWithDepartmentId(let id, _, _, _):
            return "/notices/department/\(id)/search"
        case .getNoticesByFollow:
            return "/notices/follow"
        case .searchNoticesWithFollow:
            return "/notices/follow/search"
        case .getScrappedNotices:
            return "/notices/scrap"
        case .getNoticeById(let id):
            return "/notices/\(id)"
        case .deleteNoticeScrap(let id):
            return "/notices/\(id)/scrap"
        case .createNoticeScrap(let id):
            return "/notices/\(id)/scrap"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getNoticesByDepartmentId:
            return .get
        case .searchNoticesWithDepartmentId:
            return .get
        case .getNoticesByFollow:
            return .get
        case .searchNoticesWithFollow:
            return .get
        case .getScrappedNotices:
            return .get
        case .getNoticeById:
            return .get
        case .deleteNoticeScrap:
            return .delete
        case .createNoticeScrap:
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getNoticesByDepartmentId(_, let cursor, let tags):
            
            if let cur = cursor {
                return .requestParameters(parameters:
                                            [
                                                "limit" : Const.NOTICE_LIMIT,
                                                "cursor" : cur,
                                                "tags" : tags
                                            ], encoding: URLEncoding.queryString)
            }
            return .requestParameters(parameters:
                                        [
                                            "limit" : Const.NOTICE_LIMIT,
                                            "tags" : tags
                                        ], encoding: URLEncoding.queryString)
            
            
        case .searchNoticesWithDepartmentId(_, let cursor, let tags, let keywords):
            if let cur = cursor {
                return .requestParameters(parameters:
                                            [
                                                "limit" : Const.NOTICE_LIMIT,
                                                "cursor" : cur,
                                                "tags" : tags ?? "all",
                                                "keywords" : keywords
                                            ], encoding: URLEncoding.queryString)
            }
            return .requestParameters(parameters:
                                        [
                                            "limit" : Const.NOTICE_LIMIT,
                                            "tags" : tags ?? "all",
                                            "keywords" : keywords
                                        ], encoding: URLEncoding.queryString)
            
        case .getNoticesByFollow(let cursor):
            if let cur = cursor {
                return .requestParameters(parameters:   [
                    "limit" : Const.NOTICE_LIMIT,
                    "cursor" : cur,
                ], encoding: URLEncoding.queryString)
            }
            return .requestParameters(parameters:   [
                "limit" : Const.NOTICE_LIMIT,
            ], encoding: URLEncoding.queryString)
            
        case .searchNoticesWithFollow(let cursor, let keywords):
            if let cur = cursor {
                return .requestParameters(parameters:
                                            [
                                                "limit" : Const.NOTICE_LIMIT,
                                                "cursor" : cur,
                                                "keywords" : keywords
                                            ], encoding: URLEncoding.queryString)
            }
            return .requestParameters(parameters:
                                        [
                                            "limit" : Const.NOTICE_LIMIT,
                                            "keywords" : keywords
                                        ], encoding: URLEncoding.queryString)
            
        case .getScrappedNotices(let cursor):
            if let cur = cursor {
                return .requestParameters(parameters:   [
                    "limit" : Const.NOTICE_LIMIT,
                    "cursor" : cur,
                ], encoding: URLEncoding.queryString)
            }
            return .requestParameters(parameters:   [
                "limit" : Const.NOTICE_LIMIT,
            ], encoding: URLEncoding.queryString)
            
        case .getNoticeById:
            return .requestPlain
            
        case .deleteNoticeScrap:
            return .requestPlain
            
        case .createNoticeScrap:
            return .requestPlain
        
        
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json",
                "Authorization": TokenUtils.getAccessTokenHeader()!]
        
    }
    
    
}




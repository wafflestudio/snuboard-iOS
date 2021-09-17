//
//  NoticeService.swift
//  snuboard
//
//  Created by Subeen Park on 2021/09/10.
//


import Moya
import RxSwift

final class NoticeService: BaseService<NoticeAPI> {
    static let shared = NoticeService()
    private override init() {}
    
    func getNoticesByDepartmentId(id: Int, cursor: String?, tags: String) -> Single<Response> {
        return request(.getNoticesByDepartmentId(id: id, cursor: cursor, tags: tags))
    }
    
    func getScrappedNotices(cursor: String?) -> Single<Response> {
        
        return request(.getScrappedNotices(cursor: cursor))
    }
    
    func getNoticesByFollow(cursor: String?) -> Single<Response> {
        return request(.getNoticesByFollow(cursor: cursor))
    }
    
    func getNoticeById(id: Int) -> Single<Response> {
        return request(.getNoticeById(id: id))
    }
    
    func searchNoticesWithDepartmentId(id: Int, cursor: String?, tags: String, keywords: String) -> Single<Response> {
        return request(.searchNoticesWithDepartmentId(id: id, cursor: cursor, tags: tags, keywords: keywords))
    }
    
    func deleteNoticeScrap(id: Int) -> Single<Response> {
        return request(.deleteNoticeScrap(id: id))
    }
    
    func createNoticeScrap(id: Int) -> Single<Response> {
        return request(.createNoticeScrap(id: id))
    }
    
    func searchNoticesWithFollow(cursor: String?, keywords: String) -> Single<Response> {
        return request(.searchNoticesWithFollow(cursor: cursor, keywords: keywords))
    }
}

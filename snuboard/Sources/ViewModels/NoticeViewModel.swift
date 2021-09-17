//
//  NoticeViewModel.swift
//  snuboard
//
//  Created by Subeen Park on 2021/09/08.
//

import Foundation
import Moya
import RxSwift

class NoticeViewModel: ObservableObject, RandomAccessCollection {
    
    
    enum TYPE {
        case department
        case scrap
        case follow
    }
    
    @Published var notices: [NoticeSummary] = []
    @Published var nextCursor: String? = nil
    var isLastPage = false
    var type: TYPE = .department
    var deptId: Int? = nil
    @Published var noMoreContent = false
    
    // Random access position
    typealias Element = NoticeSummary
    
    init() {}
    init(type: NoticeViewModel.TYPE) {
        self.type = type
    }
    
    subscript(position: Index) -> NoticeSummary {
        return notices[position]
    }
    
    var startIndex: Int {
        notices.startIndex
    }
    
    var endIndex: Int {
        notices.endIndex
    }
    
    var disposeBag = DisposeBag()
    
    
    func loadMoreNoticesByDepartmentId(tags: [String]) {
        
        guard let id = self.deptId else {
            print("Wrong API Call: searchNoticesWithDepartmentId")
            return
        }
        
        NoticeService.shared.getNoticesByDepartmentId(id: id, cursor: self.nextCursor, tags: tags.joined(separator: ","))
            .map(NoticeSummaryDataModel.self)
            .subscribe(
                onSuccess: { data in
                    // save department list in raw
                    self.nextCursor = data.nextCursor
                    self.notices.append(contentsOf: data.notices)
                    if data.nextCursor == "" {
                        self.noMoreContent = true
                    }
                },
                onError: {
                    print("DepartmentListViewModel: getAllDepartments")
                    print("==== error: \($0)")
                }
            ).disposed(by: disposeBag)
    }
    
    func getScrappedNotices() {
        self.nextCursor = nil
        self.notices = []
        
        loadMoreScrappedNotices()
    }
    
    func loadMoreScrappedNotices() {
        
        NoticeService.shared.getScrappedNotices(cursor: self.nextCursor)
            .map(NoticeSummaryDataModel.self)
            .subscribe(
                onSuccess: { data in
                    // save department list in raw
                    self.nextCursor = data.nextCursor
                    if data.nextCursor == "" {
                        self.noMoreContent = true
                    }
                    self.notices.append(contentsOf: data.notices)
                },
                onError: {
                    print("DepartmentListViewModel: loadMoreScrappedNotices")
                    print("==== error: \($0)")
                }
            ).disposed(by: disposeBag)
        
    }
    
    func getNoticesByFollow() {
        self.nextCursor = nil
        self.notices = []
        
        loadMoreFollowingNotices()
    }
    
    func loadMoreFollowingNotices() {
        
        NoticeService.shared.getNoticesByFollow(cursor: self.nextCursor)
            .map(NoticeSummaryDataModel.self)
            .subscribe(
                onSuccess: { data in
                    // save department list in raw
                    self.nextCursor = data.nextCursor
                    if data.nextCursor == "" {
                        self.noMoreContent = true
                    }
                    self.notices.append(contentsOf: data.notices)
                },
                onError: {
                    print("DepartmentListViewModel: loadMoreFollowingNotices")
                    print("==== error: \($0)")
                }
            ).disposed(by: disposeBag)
    }
    
    
    func initModelWithDepartmentId(id: Int, tags: [String]) {
        self.type = .department
        self.deptId = id
        self.notices = []
        self.nextCursor = nil
        
        loadMoreNoticesByDepartmentId(tags: tags)
    }
    
    
    func loadMoreSearchResultsByDepartmentId(tags: [String], keywords: String) {
        
        guard let id = self.deptId else {
            print("Wrong API Call: searchNoticesWithDepartmentId")
            return
        }
        
        NoticeService.shared.searchNoticesWithDepartmentId(id: id, cursor: self.nextCursor, tags: tags.joined(separator: ","), keywords: keywords)
            .map(NoticeSummaryDataModel.self)
            .subscribe(
                onSuccess: { data in
                    // save department list in raw
                    self.nextCursor = data.nextCursor
                    if data.nextCursor == "" {
                        self.noMoreContent = true
                    }
                    self.notices.append(contentsOf: data.notices)
                },
                onError: {
                    print("DepartmentListViewModel: getAllDepartments")
                    print("==== error: \($0)")
                }
            ).disposed(by: disposeBag)
        
    }
    
    func searchNoticesWithDepartmentId(tags: [String], keywords: String) {
        
        self.nextCursor = nil
        self.notices = []
        
        self.loadMoreSearchResultsByDepartmentId(tags: tags, keywords: keywords)
        
    }
    
    func loadMoreSearchResultsByFollow(keywords: String) {
        

        NoticeService.shared.searchNoticesWithFollow(cursor: self.nextCursor, keywords: keywords)
            .map(NoticeSummaryDataModel.self)
            .subscribe(
                onSuccess: { data in
                    // save department list in raw
                    self.nextCursor = data.nextCursor
                    if data.nextCursor == "" {
                        self.noMoreContent = true
                    }
                    self.notices.append(contentsOf: data.notices)
                },
                onError: {
                    print("DepartmentListViewModel: loadMoreSearchResultsByFollow")
                    print("==== error: \($0)")
                }
            ).disposed(by: disposeBag)
        
    }
    
    
    func searchNoticesWithFollow(keywords: String) {
        self.notices = []
        self.nextCursor = nil
        self.loadMoreSearchResultsByFollow(keywords: keywords)
    }
    
    func deleteNoticeScrap(id: Int) {
        NoticeService.shared.deleteNoticeScrap(id: id)
            .map(NoticeDetail.self)
            .subscribe(
                onSuccess: { data in
                    if let noticeIdx = self.notices.firstIndex(where: { $0.id == data.id }) {
                        self.notices[noticeIdx].isScrapped = false
                            print("\(data.id)-deleted!")
                        }
                },
                onError: {
                    print("DepartmentListViewModel: deleteNoticeScrap")
                    print("==== error: \($0)")
                }
            ).disposed(by: disposeBag)
        
    }
    
    func createNoticeScrap(id: Int) {
        NoticeService.shared.createNoticeScrap(id: id)
            .map(NoticeDetail.self)
            .subscribe(
                onSuccess: { data in
                    if let noticeIdx = self.notices.firstIndex(where: { $0.id == data.id }) {
                        self.notices[noticeIdx].isScrapped = true
                            print("\(data.id)-scrapped!")
                        }
                },
                onError: {
                    print("DepartmentListViewModel: deleteNoticeScrap")
                    print("==== error: \($0)")
                }
            ).disposed(by: disposeBag)
        
    }
    
    
    
}

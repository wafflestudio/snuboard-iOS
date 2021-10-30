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
        case search
    }
    
    @Published var notices: [NoticeSummary] = []
    @Published var nextCursor: String? = nil
    var isLastPage = false
    var type: TYPE = .department
    var deptId: Int? = nil
    @Published var noMoreContent = false
    @Published var loading = false
    
    // Random access position
    typealias Element = NoticeSummary
    
    init() {
        self.type = .search
    }
    init(type: NoticeViewModel.TYPE) {
        self.loading = true
        self.type = type
        
        if (type == .follow) {
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
                        self.loading = false
                    },
                    onError: {
                        self.loading = false
                        print("DepartmentListViewModel: loadMoreFollowingNotices")
                        print("==== error: \($0)")
                    }
                ).disposed(by: disposeBag)
        }
        
        if (type == .scrap) {
            self.loading = true
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
                        self.loading = false
                    },
                    onError: {
                        print("DepartmentListViewModel: loadMoreScrappedNotices")
                        print("==== error: \($0)")
                        self.loading = false
                    }
                ).disposed(by: disposeBag)
            
        }
        
    }
    

    
    init(id: Int, tags: [String]) {
        self.type = .department
        self.deptId = id
        self.notices = []
        self.nextCursor = nil
        
        guard let id = self.deptId else {
            print("Wrong API Call: init(id)")
            return
        }
        
        self.loading = true
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
                    self.loading = false
                },
                onError: {
                    print("DepartmentListViewModel: getAllDepartments")
                    print("==== error: \($0)")
                    self.loading = false
                }
            ).disposed(by: disposeBag)
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
        
        self.loading = true
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
                    self.loading = false
                },
                onError: {
                    print("DepartmentListViewModel: getAllDepartments")
                    print("==== error: \($0)")
                    self.loading = false
                }
            ).disposed(by: disposeBag)
    }
    
    func getScrappedNotices() {
        self.nextCursor = nil
        self.notices = []
        
        loadMoreScrappedNotices()
    }
    
    func loadMoreScrappedNotices() {
        self.loading = true
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
                    self.loading = false
                },
                onError: {
                    print("DepartmentListViewModel: loadMoreScrappedNotices")
                    print("==== error: \($0)")
                    self.loading = false
                }
            ).disposed(by: disposeBag)
    }
    
    func getNoticesByFollow() {
        self.nextCursor = nil
        self.notices = []
        
        loadMoreFollowingNotices()
    }
    
    func loadMoreFollowingNotices() {
        self.loading = true
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
                    self.loading = false
                },
                onError: {
                    print("DepartmentListViewModel: loadMoreFollowingNotices")
                    print("==== error: \($0)")
                    self.loading = false
                }
            ).disposed(by: disposeBag)
    }
    
    

    
    
    func loadMoreSearchResultsByDepartmentId(tags: [String], keywords: String) {
        self.loading = true
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
                    self.loading = false
                },
                onError: {
                    print("DepartmentListViewModel: getAllDepartments")
                    print("==== error: \($0)")
                    self.loading = false
                }
            ).disposed(by: disposeBag)
        
        
    }
    
  
    
    func loadMoreSearchResultsByFollow(keywords: String) {
        
        self.loading = true
        NoticeService.shared.searchNoticesWithFollow(cursor: self.nextCursor, keywords: keywords)
            .map(NoticeSummaryDataModel.self)
            .subscribe(
                onSuccess: { data in
                    // save department list in raw
                    self.nextCursor = data.nextCursor
                    if data.nextCursor == "" {
                        print("Next cursor nil")
                        self.noMoreContent = true
                    }
                    self.notices.append(contentsOf: data.notices)
                    self.loading = false
                },
                onError: {
                    print("DepartmentListViewModel: loadMoreSearchResultsByFollow")
                    print("==== error: \($0)")
                    self.loading = false
                }
            ).disposed(by: disposeBag)
    }
    
    
    func searchNoticesWithFollow(keywords: String) {
        self.notices = []
        self.nextCursor = nil
        self.loadMoreSearchResultsByFollow(keywords: keywords)
    }
    
    func deleteNoticeScrap(id: Int) {
        self.loading = true
        NoticeService.shared.deleteNoticeScrap(id: id)
            .map(NoticeDetail.self)
            .subscribe(
                onSuccess: { data in
                    if let noticeIdx = self.notices.firstIndex(where: { $0.id == data.id }) {
                        self.notices[noticeIdx].isScrapped = false
                            print("\(data.id)-deleted!")
                        }
                    self.loading = false
                },
                onError: {
                    print("DepartmentListViewModel: deleteNoticeScrap")
                    print("==== error: \($0)")
                    self.loading = false
                }
            ).disposed(by: disposeBag)

    }
    
    func createNoticeScrap(id: Int) {
        self.loading = true
        NoticeService.shared.createNoticeScrap(id: id)
            .map(NoticeDetail.self)
            .subscribe(
                onSuccess: { data in
                    if let noticeIdx = self.notices.firstIndex(where: { $0.id == data.id }) {
                        self.notices[noticeIdx].isScrapped = true
                            print("\(data.id)-scrapped!")
                        }
                    self.loading = false
                },
                onError: {
                    print("DepartmentListViewModel: deleteNoticeScrap")
                    print("==== error: \($0)")
                    self.loading = false
                }
            ).disposed(by: disposeBag)
    }
    
    
    
}

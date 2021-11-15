//
//  DepartmentViewModel.swift
//  snuboard
//
//  Created by Subeen Park on 2021/10/28.
//


import Foundation
import Moya
import RxSwift
import FirebaseMessaging


class DepartmentViewModel: ObservableObject {
    
    @Published var department: Department = Department(id: -1, name: "", college: "", link: "", tags: [], follow: [])
    @Published var noMoreContent = false
    @Published var loading = false
    
    @Published var notices: [NoticeSummary] = []
    @Published var nextCursor: String? = nil
    var isLastPage = false
    var disposeBag = DisposeBag()
    

    
    init(id: Int, name: String) {
        self.loading = true
        
        DepartmentService.shared.getDepartmentById(id: id)
            .map(Department.self)
            .subscribe(
                onSuccess: { data in
                    self.department = data
                },
                onError: {
                    self.loading = false
                    print("DepartmentViewModel: init - getDepartmentById")
                    print("==== error: \($0)")
                }
            )
            .disposed(by: disposeBag)
        
        let tags = UserDefaults.standard.queryParameters[name] ?? []
        print("TAGS: \(tags)")
        
        NoticeService.shared.getNoticesByDepartmentId(id: id, cursor: self.nextCursor, tags: tags.joined(separator: ","))
            .map(NoticeSummaryDataModel.self)
            .subscribe(
                onSuccess: { data in
                    // save department list in raw
                    self.nextCursor = data.nextCursor
                    self.notices = data.notices
                    self.loading = false
                },
                onError: {
                    print("DepartmentViewModel: getNoticesByDepartmentId")
                    print("==== error: \($0)")
                    self.loading = false
                }
            ).disposed(by: disposeBag)
        
    }
    
    func initNotices(tags: [String]) {
        self.notices = []
        self.nextCursor = nil
        loadMoreNoticesByDepartmentId(tags: tags)
    }
    
    
    
    func loadMoreNoticesByDepartmentId(tags: [String]) {
        
        self.loading = true

        NoticeService.shared.getNoticesByDepartmentId(id: self.department.id,
                                                      cursor: self.nextCursor,
                                                      tags: tags.joined(separator: ","))
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
    
    func createDepartmentFollow(follow: String) {
        self.loading = true
        DepartmentService.shared.createDepartmentFollow(id: department.id, follow: follow)
            .map(Department.self)
            .subscribe(
                onSuccess: { data in
                    
                    self.department = data
                    print("\(data.name)-\(data.follow) followed!")
                    self.loading = false
                    
                },
                onError: {
                    print("DepartmentListViewModel: getAllDepartments")
                    print("==== error: \($0)")
                    self.loading = false
                }
            ).disposed(by: disposeBag)
        
    }
    
    func deleteDepartmentFollow(follow: String) {
        self.loading = true
        DepartmentService.shared.deleteDepartmentFollow(id: department.id, follow: follow)
            .map(Department.self)
            .subscribe(
                onSuccess: { data in
                    self.department = data
                    print("\(data.name)-\(follow) deleted!")
                    self.loading = false
                },
                onError: {
                    print("DepartmentListViewModel: getAllDepartments")
                    print("==== error: \($0)")
                    self.loading = false
                }
            ).disposed(by: disposeBag)
        
    }
    
    func followTopic(topic: String) {

        let encodedTopic = "\(department.name)/\(topic)".toBase64URL()
        Messaging.messaging().subscribe(toTopic: encodedTopic) { error in
            print("\(topic) : \(encodedTopic) subscribed")
            print("Error \(error)")
        }
        

    }
    
    
    
    func unfollowTopic(topic: String) {

        let encodedTopic = "\(department.name)/\(topic)".toBase64URL()
        Messaging.messaging().unsubscribe(fromTopic: encodedTopic) { error in
            print("\(topic) : \(encodedTopic) unsubscribed")
            print("Error \(error)")
        }

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
  
    
    
    func searchNoticesWithDepartmentId(tags: [String], keywords: String) {
        
        self.nextCursor = nil
        self.notices = []
        
        self.loadMoreSearchResultsByDepartmentId(tags: tags, keywords: keywords)
        
    }
    
    func loadMoreSearchResultsByDepartmentId(tags: [String], keywords: String) {
        self.loading = true
        NoticeService.shared.searchNoticesWithDepartmentId(id: department.id, cursor: self.nextCursor, tags: tags.joined(separator: ","), keywords: keywords)
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
    
    func initModelWithDepartmentId(id: Int, tags: [String]) {

        self.notices = []
        self.nextCursor = nil
        
        loadMoreNoticesByDepartmentId(tags: tags)
    }

}


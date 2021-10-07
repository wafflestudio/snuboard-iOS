//
//  NoticeDetailViewModel.swift
//  snuboard
//
//  Created by Subeen Park on 2021/09/10.
//

import Foundation
import Moya
import RxSwift

class NoticeDetailViewModel: ObservableObject {
    
    @Published var notice: NoticeDetail = NoticeDetail(id: 0, title: "", content: "", createdAt: "12345678", isPinned: false, link: "", files: [], isScrapped: false, departmentID: 3, departmentName: "", tags: [])
    private let disposeBag = DisposeBag()
    @Published var loading = false
    var id: Int
    
    init(id: Int) {
        self.id = id
        self.loading = true

    }

    
    func deleteNoticeScrap(id: Int) {
        self.loading = true
        NoticeService.shared.deleteNoticeScrap(id: id)
            .map(NoticeDetail.self)
            .subscribe(
                onSuccess: { data in
                    self.notice = data
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
                    self.notice = data
                    self.loading = false
                },
                onError: {
                    print("DepartmentListViewModel: deleteNoticeScrap")
                    print("==== error: \($0)")
                    self.loading = false
                }
            ).disposed(by: disposeBag)
        
    }
    
    func getNotice() {
        NoticeService.shared.getNoticeById(id: self.id)
            .map(NoticeDetail.self)
            .subscribe(
                onSuccess: { data in
                    self.notice = data
                    self.loading = false
                },
                onError: {
                    print("DepartmentListViewModel: getAllDepartments")
                    print("==== error: \($0)")
                    self.loading = false
                }
            ).disposed(by: disposeBag)
    }
}

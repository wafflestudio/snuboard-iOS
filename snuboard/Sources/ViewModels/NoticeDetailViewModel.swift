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
    
    init(id: Int) {
        NoticeService.shared.getNoticeById(id: id)
            .map(NoticeDetail.self)
            .subscribe(
                onSuccess: { data in
                    self.notice = data
                },
                onError: {
                    print("DepartmentListViewModel: getAllDepartments")
                    print("==== error: \($0)")
                }
            ).disposed(by: disposeBag)
    }
    
    func postNoticeScrap(id: Int) {
        print("post notice scrap // should be implemented")
        
    }
    
    func deleteNoticeScrap(id: Int) {
        
        print("delete notice scrap // should be implemented")
    }
    
}

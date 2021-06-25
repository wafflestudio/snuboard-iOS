//
//  NoticeViewModel.swift
//  snuboard
//
//  Created by Subeen Park on 2021/06/25.
//

import Foundation
import Combine

class DepartmentNoticeViewModel: ObservableObject {
    
    @Published var notices: [NoticeSummary] = []
    @Published var nextCursor: String = ""
    
    init(id: Int) {
        NoticeService.shared.getNoticesByDepartmentId(id: id) { response in

            switch response {

            case .success(let noticeData):

                self.notices = noticeData.notices
                self.nextCursor = noticeData.nextCursor
                
                print("noticesPatched")

            case .badRequest(let badRequest):
                print("badRequest: \(badRequest.message)")
                
            case .unauthorized(let unautorized):
                print("unautorized: \(unautorized.message)")

            default:
                print("Other networking error")
            }


        }
    }
    
    
   
    
}

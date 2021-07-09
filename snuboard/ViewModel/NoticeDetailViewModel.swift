//
//  NoticeDetailViewModel.swift
//  snuboard
//
//  Created by Subeen Park on 2021/07/09.
//



import Foundation
import Combine

class NoticeDetailViewModel: ObservableObject {
    
    @Published var notice: NoticeDetail = NoticeDetail(id: 0, title: "", content: "", createdAt: "12345678", isPinned: false, link: "", files: [], isScrapped: false, departmentID: 3, departmentName: "", tags: [])
    
    init(id: Int) {
        NoticeService.shared.getNoticeByNoticeId(id: id) { response in
            
            switch response {

            case .success(let noticeData):

                self.notice = noticeData
                
                print("noticesPatched")

            case .badRequest(let badRequest):
                print("badRequest: \(badRequest.message)")
                
            case .unauthorized(let unautorized):
                print("unautorized: \(unautorized.message)")

            default:
                print(response)
                print("Other networking error")
            }


        }
    }
    
    func postNoticeScrap(id: Int) {
        
        NoticeService.shared.postNoticeScrap(id: id) { response in

            switch response {

            case .success(let data):
                
                self.notice.isScrapped.toggle()

            case .badRequest(let badRequest):
                print("badRequest: \(badRequest.message)")
                
            case .unauthorized(let unautorized):
                print("unautorized: \(unautorized.message)")

            default:
                print("Other networking error")
            }

    
        }
        
    }
    
    func deleteNoticeScrap(id: Int) {
        
        NoticeService.shared.deleteNoticeScrap(id: id) { response in

            switch response {

            case .success(let data):
                self.notice.isScrapped.toggle()
                

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

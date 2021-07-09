//
//  NoticeViewModel.swift
//  snuboard
//
//  Created by Subeen Park on 2021/06/25.
//

import Foundation
import Combine

class NoticeViewModel: ObservableObject {
    
    @Published var notices: [NoticeSummary] = []
    @Published var nextCursor: String = ""
    @Published var notice: NoticeDetail?
    
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
    
    init() {
        NoticeService.shared.getScrappedNotices { response in

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
    
    
    func getAllNoticesScrapped() {
        NoticeService.shared.getScrappedNotices { response in

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
    
    
    func postNoticeScrap(id: Int) {
        
        NoticeService.shared.postNoticeScrap(id: id) { response in

            switch response {

            case .success(let data):
            
                if let noticeIdx = self.notices.firstIndex(where: { $0.id == data.id }) {
                    self.notices[noticeIdx] = data
                        print("\(data.id)-scrapped!")
                    }

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
                self.notices = self.notices.filter({ $0.id != data.id})

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

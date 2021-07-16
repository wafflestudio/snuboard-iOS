//
//  NoticeViewModel.swift
//  snuboard
//
//  Created by Subeen Park on 2021/06/25.
//

import Foundation
import Combine

class NoticeViewModel: ObservableObject {
    
    enum TYPE {
        case department
        case scrap
        case follow
    }
    
    @Published var notices: [NoticeSummary] = []
    @Published var nextCursor: String = ""
    
    init() {
        
    }
    
    init(id: Int, type: TYPE) {
        NoticeService.shared.getNoticesByDepartmentId(id: id, tags: []) { response in

            switch response {

            
            case .success(let noticeData):

                self.notices = noticeData.notices
                self.nextCursor = noticeData.nextCursor
                
                print("INIT: initializeByDepartmentId: noticesFetched")

            case .badRequest(let badRequest):
                print("badRequest: \(badRequest.message)")
                
            case .unauthorized(let unautorized):
                print("unautorized: \(unautorized.message)")

            default:
                print("INIT: initializeByDepartmentId: Other networking error")
            }


        }
    }
    
    init(type: TYPE) {
        
        
        switch type {
        case .scrap:
            NoticeService.shared.getScrappedNotices { response in

                    switch response {

                    case .success(let noticeData):

                        self.notices = noticeData.notices
                        self.nextCursor = noticeData.nextCursor
                        
                        print("INIT- getScrappedNotices: noticesFetched")

                    case .badRequest(let badRequest):
                        print("badRequest: \(badRequest.message)")
                        
                    case .unauthorized(let unautorized):
                        print("unautorized: \(unautorized.message)")

                    default:
                        print("Other networking error")
                    }
            }
            return
        case .follow:
            NoticeService.shared.getNoticesByFollow { response in

                    switch response {

                    case .success(let noticeData):

                        self.notices = noticeData.notices
                        self.nextCursor = noticeData.nextCursor
                        
                        print("INIT- getNoticesByFollow: noticesFetched")

                    case .badRequest(let badRequest):
                        print("badRequest: \(badRequest.message)")
                        
                    case .unauthorized(let unautorized):
                        print("unautorized: \(unautorized.message)")

                    default:
                        print("Other networking error")
                    }
            
            }
            return 
        default:
            return
        }
        
    }
    
    
    func getNoticesByFollow() {
        NoticeService.shared.getNoticesByFollow { response in

                switch response {

                case .success(let noticeData):

                    self.notices = noticeData.notices
                    self.nextCursor = noticeData.nextCursor
                    
                    print("getNoticesByFollow: noticesFetched")

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
                    
                    print("getAllNoticesScrapped - noticesFetched")

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
                    self.notices[noticeIdx].isScrapped.toggle()
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
    
    func deleteNoticeScrap(id: Int, isFavouriteList: Bool) {
        
        NoticeService.shared.deleteNoticeScrap(id: id) { response in

            switch response {

            case .success(let data):
                if isFavouriteList {
                    self.notices = self.notices.filter({$0.id != data.id})
                    
                }
                else {
                    if let noticeIdx = self.notices.firstIndex(where: { $0.id == data.id }) {
                        self.notices[noticeIdx].isScrapped.toggle()
                            print("\(data.id)-scrapped!")
                        }
                    
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
    
    func searchNoticesByFollowingTags(keywords: String) {
        
        NoticeService.shared.searchNoticeByFollowingTags(keywords: keywords) {response in
            
            switch response {

            case .success(let noticeData):

                self.notices = noticeData.notices
                self.nextCursor = noticeData.nextCursor
                
                print("notices searched by keywords : \(keywords)")

            case .badRequest(let badRequest):
                print("badRequest: \(badRequest.message)")
                
            case .unauthorized(let unautorized):
                print("unautorized: \(unautorized.message)")

            default:
                print("Other networking error")
            }
            
        }
        
    }
    
    func getNoticesByDepartmentId(id: Int, tags: [String]=[]) {
        NoticeService.shared.getNoticesByDepartmentId(id: id, tags: tags) { response in

            switch response {

            case .success(let noticeData):

                self.notices = noticeData.notices
                self.nextCursor = noticeData.nextCursor
                
                print("getNoticesByDepartmentId: initializeByDepartmentId: noticesFetched")

            case .badRequest(let badRequest):
                print("badRequest: \(badRequest.message)")
                
            case .unauthorized(let unautorized):
                print("unautorized: \(unautorized.message)")

            default:
                print("getNoticesByDepartmentId: Other networking error")
            }


        }
    }
    
    
    func searchNoticesWithDepartmentId(id: Int, tags: [String], keywords: String) {
        
        NoticeService.shared.searchNoticeWithDepartmentId(id: id, tags: tags, keywords: keywords) {response in
            
            switch response {

            case .success(let noticeData):

                self.notices = noticeData.notices
                self.nextCursor = noticeData.nextCursor
                
                print("notices searched by keywords : \(keywords)")

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

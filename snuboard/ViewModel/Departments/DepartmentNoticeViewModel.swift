//
//  NoticeViewModel.swift
//  snuboard
//
//  Created by Subeen Park on 2021/06/25.
//

import Foundation
import Combine

class Notice: ObservableObject {
    
    @Published var notice: Notice
    
    init(id: Int) {
        
        NoticeService.shared.getNoticesByDepartmentId(id: id) { response in

            switch response {

            case .success(let noticeList):

                
                let departmentDictionary = Dictionary(grouping: departmentList, by: { $0.college })
                for college in Const.College.colleges {
                    
                    if let depts = departmentDictionary[college] {
                        self.colleges.append(College(college: college, departments: depts))
                    } else {
                        self.colleges.append(College(college: college, departments: []))
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
        
    } // end of init()
    
    
    func createDepartmentFollow(id: Int, follow: String) {
        
        DepartmentService.shared.createDepartmentFollow(id: id, follow: follow) { response in

            switch response {

            case .success(let data):
                
                
                if let collegeIdx = self.colleges.firstIndex(where: { $0.college == data.college }) {
                    if let deptIdx = self.colleges[collegeIdx].departments.firstIndex(where: {$0.name == data.name}) {
                        self.colleges[collegeIdx].departments[deptIdx] = data
                        self.colleges = self.colleges
                        print("\(data.name)-\(follow) followed!")
                        
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
    
   
    
}

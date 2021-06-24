//
//  CollegeListViewModel.swift
//  snuboard
//
//  Created by Subeen Park on 2021/06/20.
//

import Foundation


class CollegeListViewModel: ObservableObject {
    
    @Published var colleges: [College] = []
    
    init() {
        
        DepartmentService.shared.getAllDepartments { response in

            switch response {

            case .success(let departmentList):

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
    
   
    
}

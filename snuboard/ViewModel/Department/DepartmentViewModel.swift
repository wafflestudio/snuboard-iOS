//
//  CollegeListViewModel.swift
//  snuboard
//
//  Created by Subeen Park on 2021/06/20.
//

import Foundation
import Combine


class DepartmentViewModel: ObservableObject {
    

    @Published var colleges: [College] = []
    @Published var depts: [Department] = []
    
    init() {
        
        DepartmentService.shared.getAllDepartments { response in

            switch response {

            case .success(let departmentList):
                
                self.depts = departmentList
                
                if UserDefaults.standard.queryParameters.isEmpty {
                    var queries: [String: [String]] = [:]
                    for dept in departmentList {
                        queries[dept.name] = []
                    }
                    UserDefaults.standard.queryParameters = queries
                }
                
                print(UserDefaults.standard.queryParameters)
                
                
                if UserDefaults.standard.deptColor.isEmpty || UserDefaults.standard.deptColor.count != departmentList.count {
                    var deptColor: [String: String] = [:]
                    for dept in departmentList {
                        if !self.depts.contains(dept) {
                        deptColor[dept.name] = Const.ColorSet.color_palette.randomElement()
                        }
                    }
                    UserDefaults.standard.deptColor = deptColor
                }
                
//                print(UserDefaults.standard.deptColor)
                
                

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
    
    
    func getAllDepartments() {
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
    }
    
    
    
    func createDepartmentFollow(id: Int, follow: String) {
        
        DepartmentService.shared.createDepartmentFollow(id: id, follow: follow) { response in

            switch response {

            case .success(let data):
                
                
                if let collegeIdx = self.colleges.firstIndex(where: { $0.college == data.college }) {
                    if let deptIdx = self.colleges[collegeIdx].departments.firstIndex(where: {$0.name == data.name}) {
                        self.colleges[collegeIdx].departments[deptIdx].follow = data.follow
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
    
    func deleteDepartmentFollow(id: Int, follow: String) {
        
        DepartmentService.shared.deleteDepartmentFollow(id: id, follow: follow) { response in

            switch response {

            case .success(let data):
                
                
                if let collegeIdx = self.colleges.firstIndex(where: { $0.college == data.college }) {
                    if let deptIdx = self.colleges[collegeIdx].departments.firstIndex(where: {$0.name == data.name}) {
                        self.colleges[collegeIdx].departments[deptIdx].follow = data.follow
                        print("\(data.name)-\(follow) deleted!")
                        
                        
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
    
    func getCollegeLoc(college: String) -> Int {
        
        return colleges.firstIndex(where: {$0.college == college}) ?? 0
        
    }
    
    
    func getDeptLoc(college: String, deptId: Int) -> Int {
        
        let collegeLoc = getCollegeLoc(college: college)
        let deptLoc = colleges[collegeLoc].departments.firstIndex(where: {$0.id == deptId})
        
        return deptLoc ?? 0
    }
    
   
    

}

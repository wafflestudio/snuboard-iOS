//
//  DepartmentListViewModel.swift
//  snuboard
//
//  Created by Subeen Park on 2021/09/08.
//

import Foundation
import Moya
import RxSwift
import FirebaseMessaging

class DepartmentListViewModel: ObservableObject {
    
    @Published var colleges: [College] = []
    @Published var depts: [Department] = []
    var disposeBag = DisposeBag()
    @Published var loading = false
    
    
    func getAllDepartments() {
        
        self.loading = true
        DepartmentService.shared.getAllDepartments()
            .map([Department].self)
            .subscribe(
                onSuccess: { data in
                    // save department list in raw
                    self.depts = data
                    
                    // group departments with college
                    let departmentDictionary = Dictionary(grouping: data, by: { $0.college })

                    // make college object
                    var newCollegeList: [College] = []
                    for college in Const.COLLEGES {
                        
                        if let depts = departmentDictionary[college] {
                            newCollegeList.append(College(college: college, departments: depts))
                        } else {
                            newCollegeList.append(College(college: college, departments: []))
                        }
                        
                    }
                    self.colleges = newCollegeList
                    
                    self.setUserDefaults()
                    self.loading = false
                    
                },
                onError: {
                    print("DepartmentListViewModel: getAllDepartments")
                    print("==== error: \($0)")
                    self.loading = false
                }
            ).disposed(by: disposeBag)

        
    }
    
    func initModel() {
        
        print("DepartmentListViewModel : initModel")
        self.getAllDepartments()

    }
    
    
    func setUserDefaults() {
        if UserDefaults.standard.queryParameters.isEmpty {
            
            print("queryParameters empty")
            
            var queries: [String: [String]] = [:]
            for dept in self.depts {
                queries[dept.name] = []
            }
            UserDefaults.standard.queryParameters = queries
            print(queries)
        }
        
        if UserDefaults.standard.deptColor.isEmpty {
            
            print("************ deptColor empty ************ ")
            
            var deptColor: [String: String] = [:]
            for dept in self.depts {
                deptColor[dept.name] = Const.Colors.color_palette.randomElement()
            }
            UserDefaults.standard.deptColor = deptColor
        }
    
        
        if UserDefaults.standard.deptColor.count !=
            self.depts.count {
            print("************ deptColor count not matching ************ ")
            var deptColor: [String: String] = [:]
            for dept in self.depts {
                print(dept.name)
                if !self.depts.contains(dept) {
                    
                deptColor[dept.name] = Const.Colors.color_palette.randomElement()
                }
            }
            UserDefaults.standard.deptColor = deptColor
        }
        
        print(UserDefaults.standard.deptColor)
    }
    
    
    
    
    func getCollegeLoc(college: String) -> Int {
        
        return colleges.firstIndex(where: {$0.college == college}) ?? 0
        
    }
    
    
    func getDeptLoc(college: String, deptId: Int) -> Int {
        
        let collegeLoc = getCollegeLoc(college: college)
        let deptLoc = colleges[collegeLoc].departments.firstIndex(where: {$0.id == deptId})
        
        return deptLoc ?? 0
    }
    
    
    

    func turnOnNotifications(deptId: Int) {
        
        guard let deptIndex = self.depts.firstIndex(where: {$0.id == deptId}) else { return }
        let department = self.depts[deptIndex]
        
        for topic in department.follow {
            let encodedTopic = "\(department.name)/\(topic)".toBase64URL()
            Messaging.messaging().subscribe(toTopic: encodedTopic) { error in
                print("\(topic) : \(encodedTopic) subscribed")
            }
            
        }
        
    }
    
    func turnOffNotifications(deptId: Int) {
        
        guard let deptIndex = self.depts.firstIndex(where: {$0.id == deptId}) else { return }
        let department = self.depts[deptIndex]
        
        for topic in department.follow {
            let encodedTopic = "\(department.name)/\(topic)".toBase64URL()
            Messaging.messaging().unsubscribe(fromTopic: encodedTopic) { error in
            }
            
        }
        
    }

    
}

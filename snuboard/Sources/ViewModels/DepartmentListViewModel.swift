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

    func getAllDepartments() {
        
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
                    
                    
                },
                onError: {
                    print("DepartmentListViewModel: getAllDepartments")
                    print("==== error: \($0)")
                }
            ).disposed(by: disposeBag)

        
    }
    
    func initModel() {
        
        print("DepartmentListViewModel : initModel")
        self.getAllDepartments()

    }
    
    func createDepartmentFollow(id: Int, follow: String) {
        DepartmentService.shared.createDepartmentFollow(id: id, follow: follow)
            .map(Department.self)
            .subscribe(
                onSuccess: { data in
                    
                    if let collegeIdx = self.colleges.firstIndex(where: { $0.college == data.college }) {
                        if let deptIdx = self.colleges[collegeIdx].departments.firstIndex(where: {$0.name == data.name}) {
                            self.colleges[collegeIdx].departments[deptIdx] = data
                            self.depts = self.depts.filter({$0.id != data.id})
                            self.depts.append(data)
                            print("\(data.name)-\(data.follow) followed!")
                            
                            
                        }
                    }
                    
                    
                },
                onError: {
                    print("DepartmentListViewModel: getAllDepartments")
                    print("==== error: \($0)")
                }
            ).disposed(by: disposeBag)
        
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
    
    func deleteDepartmentFollow(id: Int, follow: String) {
        DepartmentService.shared.deleteDepartmentFollow(id: id, follow: follow)
            .map(Department.self)
            .subscribe(
                onSuccess: { data in
                    
                    if let collegeIdx = self.colleges.firstIndex(where: { $0.college == data.college }) {
                        if let deptIdx = self.colleges[collegeIdx].departments.firstIndex(where: {$0.name == data.name}) {
                            self.colleges[collegeIdx].departments[deptIdx] = data
                            self.depts = self.depts.filter({$0.id != data.id})
                            self.depts.append(data)
                            print("\(data.name)-\(follow) deleted!")
                            
                            
                        }
                    }
                    
                    
                },
                onError: {
                    print("DepartmentListViewModel: getAllDepartments")
                    print("==== error: \($0)")
                }
            ).disposed(by: disposeBag)
        
    }
    
    
    func getCollegeLoc(college: String) -> Int {
        
        return colleges.firstIndex(where: {$0.college == college}) ?? 0
        
    }
    
    
    func getDeptLoc(college: String, deptId: Int) -> Int {
        
        let collegeLoc = getCollegeLoc(college: college)
        let deptLoc = colleges[collegeLoc].departments.firstIndex(where: {$0.id == deptId})
        
        return deptLoc ?? 0
    }
    
    func followTopic(deptId: Int, topic: String) {
        
        guard let deptIndex = self.depts.firstIndex(where: {$0.id == deptId}) else { return }
        let department = self.depts[deptIndex]

        let encodedTopic = "\(department.name)/\(topic)".toBase64URL()
        Messaging.messaging().subscribe(toTopic: encodedTopic) { error in
            print("\(topic) : \(encodedTopic) subscribed")
        }

    }
    
    func unfollowTopic(deptId: Int, topic: String) {
        
        guard let deptIndex = self.depts.firstIndex(where: {$0.id == deptId}) else { return }
        let department = self.depts[deptIndex]

        let encodedTopic = "\(department.name)/\(topic)".toBase64URL()
        Messaging.messaging().unsubscribe(fromTopic: encodedTopic) { error in
            print("\(topic) : \(encodedTopic) unsubscribed")
        }

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

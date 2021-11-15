//
//  Settings.swift
//  snuboard
//
//  Created by Subeen Park on 2021/09/10.
//


import Foundation

// Query Parameters
extension UserDefaults {
    
    var queryParameters: [String: [String]] {
        get {
            let data = object(forKey: "queryParameters") as? [String: String] ?? [:]
            var queries : [String: [String]] = [:]
            for (key, value) in data {
                if value.count == 0 {
                    queries[key] = []
                } else {
                    queries[key] = value.components(separatedBy: "&")
                }
                
            }
            return queries
        }
        set {
            var queries: [String: String] = [:]
            for (key, value) in newValue {
                if !value.isEmpty {
                   queries[key] = value.joined(separator: "&")
                } else {
                    queries[key] = ""
                }
                
            }
            set(queries, forKey: "queryParameters")
        }
    }
    
    
    
    
}

// Color Palette
extension UserDefaults {
    
    static let color_palette = ["석류", "감귤", "들국", "완두", "비취", "지중해", "하늘", "라벤더", "자수정"]
    
    var deptColor: [String: String] {
        get {
            object(forKey: "deptColor") as? [String: String] ?? [:]
        }
        set {
            set(newValue, forKey: "deptColor")
        }
    }
}



class Settings: ObservableObject{
    
    func initUserDefaults() {
        self.deptColor = UserDefaults.standard.deptColor
        self.queryParameters = UserDefaults.standard.queryParameters
    }
    
    @Published var showMenu: Bool = false


    
    @Published var deptColor: [String: String] = UserDefaults.standard.deptColor {
        didSet {
            UserDefaults.standard.deptColor = self.deptColor
            print("deptColor set: \(UserDefaults.standard.deptColor)")
        }
    }
    
    @Published var queryParameters: [String: [String]] = UserDefaults.standard.queryParameters {
        didSet {
            print(queryParameters)
            UserDefaults.standard.queryParameters = self.queryParameters
            print("USER DEFAULTS \(UserDefaults.standard.queryParameters)")
        }
    }
    
    static func updateSubscriptionStatus(for department:String, subscribe: Bool) {
        if subscribe {
            subscribeDepartment(for: department)
        } else {
            unsubscribeDepartment(for: department)
        }
    }
    
    static func subscribeDepartment(for department: String) {
        UserDefaults.standard.set(true, forKey: "\(department)Notification")
    }
    
    static func unsubscribeDepartment(for department: String) {
        UserDefaults.standard.removeObject(forKey: "\(department)Notification")
    }
    
    static func getSubsciptionStatus(for department: String) -> Bool {
        
        if UserDefaults.standard.object(forKey: "\(department)Notification") == nil {
            UserDefaults.standard.set(true, forKey: "\(department)Notification")
        }
        
        return UserDefaults.standard.bool(forKey: "\(department)Notification")
    }

    
}


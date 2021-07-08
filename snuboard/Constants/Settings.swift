//
//  Settings.swift
//  snuboard
//
//  Created by Subeen Park on 2021/07/01.
//

import Foundation

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
    
    @Published var deptColor: [String: String] = UserDefaults.standard.deptColor {
        didSet {
            UserDefaults.standard.deptColor = self.deptColor
        }
    }
}

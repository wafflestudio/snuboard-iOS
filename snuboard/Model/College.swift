//
//  College.swift
//  snuboard
//
//  Created by Subeen Park on 2021/06/20.
//

import Foundation


struct College: Identifiable, Hashable {
    
    let id = UUID()
    let college: String
    var departments: [Department] = []
    
    init(college: String, departments: [Department]) {
        self.college = college
        self.departments = departments
    }
    
}

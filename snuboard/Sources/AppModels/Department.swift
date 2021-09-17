//
//  Department.swift
//  snuboard
//
//  Created by Subeen Park on 2021/09/08.
//

import Foundation

struct Department: Codable, Hashable {
    let id: Int
    let name, college: String
    let link: String
    let tags: [String]
    var follow: [String]
}

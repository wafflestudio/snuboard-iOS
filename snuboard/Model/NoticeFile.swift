//
//  NoticeFile.swift
//  snuboard
//
//  Created by Subeen Park on 2021/06/25.
//

import Foundation

// MARK: - NoticeFile
struct NoticeFile: Codable, Identifiable {
    let id: Int
    let name: String
    let link: String
}


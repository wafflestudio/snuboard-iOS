//
//  NoticeDetail.swift
//  snuboard
//
//  Created by Subeen Park on 2021/06/25.
//

import Foundation


// MARK: - NoticeDetail
struct NoticeDetail: Codable, Identifiable {
    let id: Int
    let title, content, createdAt: String
    let isPinned: Bool
    let link: String
    let files: [NoticeFile]
    var isScrapped: Bool
    let departmentID: Int
    let departmentName: String
    let tags: [String]

    enum CodingKeys: String, CodingKey {
        case id, title, content
        case createdAt = "created_at"
        case isPinned = "is_pinned"
        case link, files
        case isScrapped = "is_scrapped"
        case departmentID = "department_id"
        case departmentName = "department_name"
        case tags
    }

}

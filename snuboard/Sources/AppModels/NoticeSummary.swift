//
//  NoticeSummary.swift
//  snuboard
//
//  Created by Subeen Park on 2021/09/10.
//

import Foundation

// MARK: - NoticeElement
struct NoticeSummary: Codable, Identifiable, Hashable {
    let id: Int
    let title, createdAt: String
    let isPinned: Bool
    let link: String
    var isScrapped: Bool
    let preview: String
    let departmentID: Int
    let departmentName: String
    let tags: [String]

    enum CodingKeys: String, CodingKey {
        case id, title
        case createdAt = "created_at"
        case isPinned = "is_pinned"
        case link
        case isScrapped = "is_scrapped"
        case preview
        case departmentID = "department_id"
        case departmentName = "department_name"
        case tags
    }
}



//
//  NoticeSummaryDataModel.swift
//  snuboard
//
//  Created by Subeen Park on 2021/06/25.
//

import Foundation


// MARK: - Notice
struct NoticeSummaryListDataModel: Codable {
    let notices: [NoticeSummary]
    let nextCursor: String

    enum CodingKeys: String, CodingKey {
        case notices
        case nextCursor = "next_cursor"
    }
}

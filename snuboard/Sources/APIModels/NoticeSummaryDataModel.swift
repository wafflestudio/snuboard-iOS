//
//  NoticeSummaryDataModel.swift
//  snuboard
//
//  Created by Subeen Park on 2021/09/10.
//

import Foundation

struct NoticeSummaryDataModel: Codable {
    let notices: [NoticeSummary]
    let nextCursor: String

    enum CodingKeys: String, CodingKey {
        case notices
        case nextCursor = "next_cursor"
    }
}

//
//  BadRequestDataModel.swift
//  snuboard
//
//  Created by Subeen Park on 2021/06/20.
//

import Foundation

struct BadRequestDataModel: Codable {
    let statusCode: Int
    let message: String
    let error: String
}

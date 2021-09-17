//
//  ResponseError.swift
//  snuboard
//
//  Created by Subeen Park on 2021/09/10.
//

import Foundation

struct ResponseError: Decodable, Error {
  var statusCode: Int?
  let message: String
}


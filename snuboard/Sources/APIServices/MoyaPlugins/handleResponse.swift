//
//  handleResponse.swift
//  snuboard
//
//  Created by Subeen Park on 2021/09/10.
//
// Reference: https://gist.github.com/susemi99/841b2c3935b2028b2162842d479de143

import Foundation
import Moya
import RxSwift

/// 서버에서 보내주는 오류 문구 파싱용
extension PrimitiveSequence where Trait == SingleTrait, Element == Response {
  func handleResponse() -> Single<Element> {
    return flatMap { response in
      // 토큰 재발급 받았을 때 토큰 변경함
      if let newToken = try? response.map(UserDataModel.self) {
        newToken.saveNewTokens()
      }
                    
      if (200 ... 299) ~= response.statusCode {
        return Single.just(response)
      }

      if var error = try? response.map(ResponseError.self) {
        error.statusCode = response.statusCode
        return Single.error(error)
      }

      // Its an error and can't decode error details from server, push generic message
      let genericError = ResponseError(statusCode: response.statusCode,
                                       message: "empty message")
      return Single.error(genericError)
    }
  }
}

/// 토큰 만료 에러
enum TokenError: Swift.Error {
  case tokenExpired
}

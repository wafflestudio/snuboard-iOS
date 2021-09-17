//
//  BaseService.swift
//  snuboard
//
//  Created by Subeen Park on 2021/09/10.
//
// Reference https://gist.github.com/susemi99/841b2c3935b2028b2162842d479de143

import Moya
import RxSwift


/// 네트워크 호출 상속용
/// https://github.com/Moya/Moya
class BaseService<API: TargetType> {
  // moya에서 지원하는 로깅 플러그인
//  private let provider = MoyaProvider<API>(plugins: [NetworkLoggerPlugin()])
  // 커스텀 로깅 플러그인
  private let provider = MoyaProvider<API>(plugins: [RequestLoggingPlugin()])

  /// 네트워크 호출
  /// help from https://github.com/Moya/Moya/issues/1177#issuecomment-345132374
  func request(_ api: API) -> Single<Response> {
    return provider.rx.request(api)
      .flatMap {
        // 401(Unauthorized) 발생 시 자동으로 토큰을 재발급 받는다
        if $0.statusCode == 401 {
          throw TokenError.tokenExpired
        } else {
          return Single.just($0)
        }
      }
      .retryWhen { (error: Observable<TokenError>) in
        error.flatMap { error -> Single<Response> in
          AuthService.shared.refreshToken() // 토큰 재발급 받기
        }
      }
      .handleResponse()
      .filterSuccessfulStatusCodes()
      .retry(2)
  }
}

//
//  NetworkResult.swift
//  snuboard
//
//  Created by Subeen Park on 2021/06/20.
//

import Foundation

import Foundation

enum NetworkResult<T> {
    case success(T)
    case badRequest(BadRequestDataModel)
//    case requestError(T)
    case unauthorized(UnautorizedDataModel)
    case pathError
    case serverError
    case networkFailure
    
    
    static func judgeStatus<T: Codable>(by statusCode: Int, data: Data) -> NetworkResult<T> {
          
        
        switch statusCode {
        
        case 200: return isValidData(data: data)
        case 201: return isValidData(data: data)
        case 400: return isBadRequest(data: data)
        case 401: return isUnauthorized(data: data)
        case 500: return .serverError
        default: return .networkFailure
        }
        
    }
    
    static private func isValidData<T: Codable>(data : Data) -> NetworkResult<T> {
        
        let decoder = JSONDecoder()

        guard let decodedData: T = try? decoder.decode(T.self, from: data)
        else { return .pathError}
        
        return .success(decodedData)

    }
    
    
    static private func isBadRequest<T: Codable>(data: Data)-> NetworkResult<T> {
        
        let decoder = JSONDecoder()

        guard let decodedData = try? decoder.decode(BadRequestDataModel.self, from: data)
        else { return .pathError}
        
        return .badRequest(decodedData)
        
    }
    
    static private func isUnauthorized<T: Codable>(data: Data) -> NetworkResult<T> {
        
        let decoder = JSONDecoder()
        
        guard let decodedData = try? decoder.decode(UnautorizedDataModel.self, from: data)
        else { return .pathError}
        
        return .unauthorized(decodedData)
    }
    
    
    
    
}


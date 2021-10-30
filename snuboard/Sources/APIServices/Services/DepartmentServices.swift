//
//  DepartmentServices.swift
//  snuboard
//
//  Created by Subeen Park on 2021/09/10.
//

import Foundation
import Moya
import RxSwift

final class DepartmentService: BaseService<DepartmentAPI> {
    static let shared = DepartmentService()
    private override init() {}
    
    func getAllDepartments() -> Single<Response> {
        return request(.getAllDepartments)
    }
    
    func createDepartmentFollow(id: Int, follow: String) -> Single<Response> {
        return request(.createDepartmentFollow(id: id, follow: follow))
    }
    
    func deleteDepartmentFollow(id: Int, follow: String) -> Single<Response> {
        return request(.deleteDepartmentFollow(id: id, follow: follow))
    }
    
    func getDepartmentById(id: Int) -> Single<Response> {
        return request(.getDepartmentById(id: id))
    }

}

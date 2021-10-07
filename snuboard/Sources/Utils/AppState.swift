//
//  AppState.swift
//  snuboard
//
//  Created by Subeen Park on 2021/10/05.
//


import SwiftUI

class AppState: ObservableObject {
    static let shared = AppState()
    @Published var pageToNavigationTo : Int?
    @Published var tabChange = false
    
    init() {
        pageToNavigationTo = UserDefaults.standard.integer(forKey: "NotificationId")
        UserDefaults.standard.removeObject(forKey: "NotificationId")
    }
}

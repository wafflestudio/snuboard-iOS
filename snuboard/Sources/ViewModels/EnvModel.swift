//
//  EnvModel.swift
//  snuboard
//
//  Created by Subeen Park on 2021/09/03.
//

import Foundation


class EnvModel: ObservableObject {
    

    
    @Published var loading = false
    @Published var isDrawerOpen: Bool = false
    
    @Published var showVersinoInfo = false
    @Published var showPrivacy = false
    @Published var showTeamSnuboard = false
    @Published var showNotification = false
    

    
    func toggleLoading() {
        print("toggleLoading called")
        loading.toggle()
    }
    
    
    

    
    
}

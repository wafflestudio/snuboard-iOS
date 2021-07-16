//
//  snuboardApp.swift
//  snuboard
//
//  Created by Subeen Park on 2021/06/14.
//

import SwiftUI

@main
struct snuboardApp: App {
    
    var body: some Scene {
        WindowGroup {
            
//            if let id = TokenUtils.loadID(), let password = TokenUtils.loadPW() {
//                MainTabView()
//                    .colorScheme(.light)
//            } else {
//                StartAppView()
//                    .colorScheme(.light)
//            }
            StartAppView()
                .colorScheme(.light)
            
        }
    }
}

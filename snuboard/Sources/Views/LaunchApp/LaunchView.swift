//
//  LaunchView.swift
//  snuboard
//
//  Created by Subeen Park on 2021/08/31.
//

import SwiftUI

struct LaunchView: View {
    
    @EnvironmentObject var envModel: EnvModel
    @StateObject var deptModel = DepartmentListViewModel()
    @StateObject var settings: Settings = Settings()
    @ObservedObject var viewModel = AuthViewModel()
    let showSignUp: Bool
    
    
    init(showSignUp: Bool) {
        self.showSignUp = showSignUp
        UITabBar.appearance().barTintColor = .white
        UITabBar.appearance().tintColor = UIColor(named: "Main Blue")
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().backgroundColor = .clear
        UINavigationBar.appearance().isTranslucent = true
    }
    
    var body: some View {
    
      
        ZStack {
            
            NavigationView {
                
                if showSignUp {
                    SignUpView()
                        .environmentObject(envModel)
                        .environmentObject(viewModel)
                } else {
                    HomeTabView()
                        .environmentObject(settings)
                        .environmentObject(envModel)
                        .environmentObject(deptModel)
                    
                }
                

            } // End of NavigationView
            .zIndex(-1)
            .environmentObject(envModel)
            
            
            if envModel.showVersinoInfo {
                Color.white.zIndex(0)
                NavigationView {
                    NavigationLink(destination: VersionInfo()
                                    .environmentObject(envModel)
                                   , isActive: $envModel.showVersinoInfo) {
                        EmptyView()
                    }
                }.zIndex(2)
            } // end of showVersionInfo
            
            if envModel.showPrivacy {
                Color.white.zIndex(0)
                NavigationView {
                    NavigationLink(destination: PrivacyPolicy()
                                    .environmentObject(envModel)
                                   , isActive: $envModel.showPrivacy) {
                        EmptyView()
                    }
                }.zIndex(2)
            } // end of showPrivacy
            
            if envModel.showTeamSnuboard {
                Color.white.zIndex(0)
                NavigationView {
                    NavigationLink(destination: DeveloperInfoView()
                                    .environmentObject(envModel)
                                   , isActive: $envModel.showTeamSnuboard) {
                        EmptyView()
                    }
                }.zIndex(2)
            } // end of showTeamSnuboard
            
            if envModel.showNotification {
                Color.white.zIndex(0)
                NavigationView {
                    NavigationLink(destination: NotificationList()
                                    .environmentObject(envModel)
                                   , isActive: $envModel.showNotification) {
                        EmptyView()
                    }
                }.zIndex(2)
            } // end of showNotification
             

            
            

            if envModel.isDrawerOpen {
                Color.white.zIndex(0)
                Color.black.opacity(0.3).edgesIgnoringSafeArea([.top, .bottom]).zIndex(0)
                    .onTapGesture {
                        envModel.isDrawerOpen.toggle()
                    }
                    .zIndex(1)
                NavigationDrawer(isOpen: envModel.isDrawerOpen)
                    .environmentObject(envModel)
                    .edgesIgnoringSafeArea([.top, .bottom])
                    .zIndex(3)
                    .transition(.move(edge: .leading))
            } // end of isDrawerOpen
            
        }
            



        
        
    } // End of Body
    
    
}

//
//  LaunchView.swift
//  snuboard
//
//  Created by Subeen Park on 2021/08/31.
//

import SwiftUI

struct LaunchView: View {
    
    @EnvironmentObject var envModel: EnvModel
    
    
    init() {
        UITabBar.appearance().barTintColor = .white
        UITabBar.appearance().tintColor = UIColor(named: "Main Blue")
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().backgroundColor = .clear
        UINavigationBar.appearance().isTranslucent = true
    }
    
    var body: some View {
    
        
        
        
        ActivityIndicatorView(isShowing: $envModel.loading) {
            
            ZStack {
                
                NavigationView {
                    
                    if TokenUtils.loadFCMtoken() != nil {
                        HomeTabView()
                            .environmentObject(envModel)
                    } else {

                        // VStack 0
                        VStack(spacing: 120) {

                            // VStack 1: logo + text
                            VStack(spacing: 20) {
                                // square logo
                                Image("squareLogo")
                                    .resizeImage(width: 141, height: 141)

                                // text
                                Text("모든 공지사항을 스누보드에서")
                                    .foregroundColor(Const.Colors.Gray3.color)
                                    .font(.system(size: 17))
                            } // End of VStack 1

                            // Button
                            NavigationLink(
                                destination: PolicyAgree(),
                                label: {
                                    Text("시작하기")
                                        .blueButtonText()
                                        .frame(width: 193, height: 40, alignment: .center)
                                        .blueButtonBackground()
                                })

                        } // End of outer VStack0
                        
                    } // end of Else clause
                    
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
            

            
            

        } // End of ActivityIndicatorView


        
        
    } // End of Body
    
    
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}

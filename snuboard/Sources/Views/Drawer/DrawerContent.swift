//
//  DrawerContent.swift
//  snuboard
//
//  Created by Subeen Park on 2021/09/03.
//
// reference: https://www.iosapptemplates.com/blog/swiftui/navigation-drawer-swiftui

import SwiftUI

struct DrawerContent: View {
    
    @EnvironmentObject var envModel: EnvModel
    
    var body: some View {
        
        NavigationView {
            
            VStack {

//                HStack {
//                    Button(action: {
//                        print("button tapped")
//                    }, label: {
//                        Image("close")
//                            .padding(.init(top: 48, leading: 12, bottom: 0, trailing: 0))
//                    })
//                Spacer()
//                }
//
                Spacer().frame(height: 20)

                
                VStack(alignment: .leading, spacing: 15) {
                    
                    // App Stack
                    
                    Text("App")
                        .font(.system(size: 14))
                        .foregroundColor(Const.Colors.MenuGray.color)
                        .padding(.leading, 16)
                    
                    
                    VStack(spacing: 0) {
                        
                        HStack(spacing: 24) {
                            Image("system_update")
                            Text("버전 정보")
                            Spacer()
                        }
                        .frame(height: 48)
                        .onTapGesture {
                            envModel.isDrawerOpen = false
                            envModel.showVersinoInfo = true
                        }
                        
                        HStack(spacing: 24) {
                            Image("library_books")
                            Text("개인정보처리방침")
                            Spacer()
                        }
                        .frame(height: 48)
                        .onTapGesture {
                            envModel.isDrawerOpen = false
                            envModel.showPrivacy = true
                        }

                        Link(destination: URL(string: "googlegmail:///co?to=snuboard@waffle.com")!) {
                            HStack(spacing: 24) {
                                Image("email")
                                Text("개발자 괴롭히기")
                                Spacer()
                            }
                            .frame(height: 48)
                        }
                        
                        HStack(spacing: 24) {
                            Image("groups")
                            Text("팀 스누보드")
                            Spacer()
                        }
                        .frame(height: 48)
                        .onTapGesture {
                            envModel.isDrawerOpen = false
                            envModel.showTeamSnuboard = true
                        }
                    
                    } // End of App Stack
                    .font(.system(size: 14)).foregroundColor(.black)
                    .padding(.leading, 16)
                    
                    
                    Divider()
                    
                    // Notification Stack
                    
                    Text("Notification")
                        .font(.system(size: 14))
                        .foregroundColor(Const.Colors.MenuGray.color)
                        .padding(.leading, 16)
                    
                    
                    VStack(spacing: 0) {
                        

                        HStack(spacing: 24) {
                            Image("notifications_none")
                            Text("알림 목록")
                            Spacer()
                        }
                        .frame(height: 48)
                        .onTapGesture {
                            envModel.isDrawerOpen = false
                            envModel.showNotification = true
                        }

                        
                    } // End of Notification Stack
                    .font(.system(size: 14)).foregroundColor(.black)
                    .padding(.leading, 16)
                    .transition(.move(edge: .leading))
                    
                    Spacer()

                    
                    
                }
                Spacer()
                
            } // End of VStack
            .navigationBarTitle("", displayMode: .inline)
            .hideNavigationBar()
            .transition(.move(edge: .leading))
            
        } // end of navigation view
    } // end of body
}



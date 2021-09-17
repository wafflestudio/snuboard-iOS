//
//  NotificationList.swift
//  snuboard
//
//  Created by Subeen Park on 2021/09/08.
//

import SwiftUI
import CoreData


struct NotificationList: View {
    
    @State var alarmTurnedOn: Bool = false
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var envModel: EnvModel
    @State var notifications: [NotificationDataModel] = []
    
    
    var body: some View {

        VStack {
            
            if notifications.isEmpty {
                Spacer()
                HStack {
                    Spacer()
                    Image("alarmCat")
                        .resizable()
                        .frame(width: 336, height: 336, alignment: .center)
                    Spacer()
                    
                }
                Spacer()
            } else {
                
                ScrollView {
                    
                    ForEach(notifications, id: \.self) { notice in
                        
                        NavigationLink(destination: NoticeDetailView(id: Int(notice.noticeId))) {
                            VStack(alignment: .leading, spacing: 8) {
                                
                                NoticeTagListView(dept: notice.departmentName!, tags: notice.tags!.components(separatedBy: ";"))
                                
                                HStack {
                                    Text(notice.title!)
                                        .font(.system(size: 16))
                                        .foregroundColor(Color.black)
                                        .bold()
                                }
                                HStack {
                                    Text(notice.preview!)
                                        .font(.system(size: 12))
                                        .foregroundColor(Color.black)
                                        .lineLimit(2)
                                }
                                
                            } // End of VStack
                            .padding(12)
                            .background(RoundedRectangle(cornerRadius: 8).foregroundColor(.white))
                            
                        }
                        
                        
                        
        
                    } // End of ForEach
                    
                } // End of ScrollView
                .padding(.top, 1)
                .padding(12)
                .background(Const.Colors.BgGray.color)
                
                
            }
            
        }
        .onAppear {
            self.notifications = NotificationDataHandler.fetchNotifications()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .background(Const.Colors.BgGray.color).edgesIgnoringSafeArea(.bottom)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Image("navigateBefore").onTapGesture {
                    envModel.showNotification = false
                    envModel.isDrawerOpen = true
                    presentationMode.wrappedValue.dismiss()
                }
            }
            ToolbarItem(placement: .principal) {
                Text("알림 목록")
                    .bold()
                    .font(.system(size: 20))
            }
//            ToolbarItem(placement: .navigationBarTrailing) {
//                Image("\(alarmTurnedOn ? "notifications_active" : "notifications_off")")
//                    .resizable()
//                    .frame(width: 24, height: 24, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//                    .onTapGesture {
//                        alarmTurnedOn.toggle()
//                    }
//            }
        }
   
    }
    
    

}

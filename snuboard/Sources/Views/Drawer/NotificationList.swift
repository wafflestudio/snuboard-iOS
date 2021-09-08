//
//  NotificationList.swift
//  snuboard
//
//  Created by Subeen Park on 2021/09/08.
//

import SwiftUI


struct NotificationList: View {
    
    @State var alarmTurnedOn: Bool = false
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var envModel: EnvModel
    
    var body: some View {
        
        VStack {
            Spacer()
            HStack {
                Spacer()
                Image("alarmCat")
                    .resizable()
                    .frame(width: 336, height: 336, alignment: .center)
                Spacer()
                
            }
            Spacer()
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
            ToolbarItem(placement: .navigationBarTrailing) {
                Image("\(alarmTurnedOn ? "notifications_active" : "notifications_off")")
                    .resizable()
                    .frame(width: 24, height: 24, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .onTapGesture {
                        alarmTurnedOn.toggle()
                    }
            }
        }
   
    }

}

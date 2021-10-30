//
//  DepartmentSettingView.swift
//  snuboard
//
//  Created by Subeen Park on 2021/10/28.
//

import SwiftUI

struct DepartmentSettingView: View {
    
    @EnvironmentObject var deptModel: DepartmentViewModel
    @EnvironmentObject var settings: Settings
    
    @Environment(\.presentationMode) var presentationMode
    @State var isAlarmTurnedOn: Bool = true {
        willSet {
            if newValue {
                deptModel.department.follow.forEach { topic in
                    deptModel.followTopic(topic: topic)
                }
            }
            else {
                deptModel.department.follow.forEach { topic in
                    deptModel.unfollowTopic(topic: topic)
                }
            }
            Settings.updateSubscriptionStatus(for: deptModel.department.name, subscribe: newValue)
        }
    }
    

    var body: some View {
        VStack {
            
            // Follow-Chip
            VStack {
                HStack {
                    Image("tag")
                        .resizable()
                        .frame(width: 20, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    Text("팔로우할 태그를 선택해주세요")
                        .foregroundColor(Const.Colors.Gray1.color)
                        .font(.system(size: 16))
                        .bold()
                    Spacer()
                }
            
                FollowTagChipView(notificationTurnedOn: $isAlarmTurnedOn)
                    .environmentObject(deptModel)
            }
            .padding(12)
            .background(RoundedRectangle(cornerRadius: 8).foregroundColor(.white))
            
            VStack {
                HStack {
                    Image("notifications_none")
                        .resizable()
                        .frame(width: 20, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    Text("새 게시물의 알림을 받을까요?")
                        .foregroundColor(Const.Colors.Gray1.color)
                        .font(.system(size: 16))
                        .bold()
                    Spacer()
                    Image("\(isAlarmTurnedOn ? "notifications_active" : "notifications_off")")
                        .resizable()
                        .frame(width: 20, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .onTapGesture {
                            isAlarmTurnedOn.toggle()
                        }
                }
            }
            .padding(12)
            .background(RoundedRectangle(cornerRadius: 8).foregroundColor(.white))
            
            // Palette-Chip
            VStack {
                HStack {
                    Image("color_lens")
                        .resizable()
                        .frame(width: 20, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    Text("학과의 색상을 선택해주세요")
                        .foregroundColor(Const.Colors.Gray1.color)
                        .font(.system(size: 16))
                        .bold()
                    Spacer()
                }
                ColorPalette(dept: deptModel.department.name)
                    .environmentObject(settings)
            }
            .padding(12)
            .background(RoundedRectangle(cornerRadius: 8).foregroundColor(.white))
            
            Spacer()
            
            
        } // End of VStack {
        .onAppear {
            self.isAlarmTurnedOn = Settings.getSubsciptionStatus(for: deptModel.department.name)
        }
        .padding(10)
        .background(Const.Colors.BgGray.color.ignoresSafeArea())
        .navigationBarTitle(deptModel.department.name, displayMode: .inline)
        .navigationBarBackButtonHidden(true)

    }
}

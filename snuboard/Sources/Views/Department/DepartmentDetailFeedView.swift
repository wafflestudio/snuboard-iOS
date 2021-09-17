//
//  DepartmentDetailFeedView.swift
//  snuboard
//
//  Created by Subeen Park on 2021/09/10.
//

import SwiftUI


struct DepartmentDetailFeedView: View {
    
    @EnvironmentObject var deptModel: DepartmentListViewModel
    @EnvironmentObject var settings: Settings
    @Environment(\.presentationMode) var presentationMode
    
    var dept: Department
    var collegeId: Int = 0
    @State var isAlarmTurnedOn: Bool = false
    
    init(dept: Department) {
        self.dept = dept
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
                FeedTagListView(id: dept.id, college: dept.college, notificationTurnedOn: $isAlarmTurnedOn)
                    .environmentObject(deptModel)
                    .environmentObject(settings)
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
                            
                            Settings.updateSubscriptionStatus(for: self.dept.name, subscribe: isAlarmTurnedOn)
                            if isAlarmTurnedOn {
                                deptModel.turnOnNotifications(deptId: self.dept.id)
                            }
                            else {
                                deptModel.turnOffNotifications(deptId: self.dept.id)
                            }

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
                ColorPalette(dept: dept.name)
            }
            .padding(12)
            .background(RoundedRectangle(cornerRadius: 8).foregroundColor(.white))
            
            Spacer()
            
            
        } // End of VStack {
        .onAppear {
            self.isAlarmTurnedOn = Settings.getSubsciptionStatus(for: dept.name)
        }
        .padding(10)
        .background(Const.Colors.BgGray.color.ignoresSafeArea())
        .navigationBarTitle(dept.name, displayMode: .inline)
        .navigationBarBackButtonHidden(true)

        
        
        
    }
}

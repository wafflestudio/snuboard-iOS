//
//  FollowTagChipView.swift
//  snuboard
//
//  Created by Subeen Park on 2021/10/29.
//

import SwiftUI

struct FollowTagChipView: View {

    @EnvironmentObject var deptModel: DepartmentViewModel
    @Binding var notificationTurnedOn: Bool
    
    init(notificationTurnedOn: Binding<Bool>) {
        self._notificationTurnedOn = notificationTurnedOn
    }
    

    var body: some View {
        FlexibleView(
            data: deptModel.department.tags,
            spacing: 5,
                alignment: .leading
              )  { item in
                  
                  Text(verbatim: item)
                      .font(.system(size: 11))
                      .foregroundColor(.white)
                      .bold()
                      .padding(5)
                      .padding(.leading, 4)
                      .padding(.trailing, 4)
                      .background(
                          RoundedRectangle(cornerRadius: 8)
                            .fill(deptModel.department.follow.contains(item) ? Const.Colors.MainBlue.color : Const.Colors.Unselected.color)
                      )
                      .onTapGesture {
                          
                          if deptModel.department.follow.contains(item) {
                              deptModel.deleteDepartmentFollow(follow: item)
                              if notificationTurnedOn {
                                  deptModel.unfollowTopic(topic: item)
                              }
                          }
                          else {
                              deptModel.createDepartmentFollow(follow: item)
                              if notificationTurnedOn {
                                  deptModel.followTopic(topic: item)
                              }
                          }
                          
                      }
                
          }
    }
}


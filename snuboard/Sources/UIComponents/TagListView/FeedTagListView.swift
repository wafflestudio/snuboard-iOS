//
//  FeedTagListView.swift
//  snuboard
//
//  Created by Subeen Park on 2021/09/10.
//

import SwiftUI

struct FeedTagListView: View {
    
    @EnvironmentObject var deptModel: DepartmentListViewModel
    
    let id: Int
    let college: String
    @Binding var notificationTurnedOn: Bool


    init (id: Int, college: String, notificationTurnedOn: Binding<Bool>) {

        self.id = id
        self.college = college
        self._notificationTurnedOn = notificationTurnedOn

    }
    
    
    var body: some View {
        
        FlexibleView(
            data: deptModel.colleges[deptModel.getCollegeLoc(college: college)].departments[deptModel.getDeptLoc(college: college, deptId: id)].tags,
            spacing: 8,
                alignment: .leading
              )  { item in
            TagChipView(item: item, selected: deptModel.colleges[deptModel.getCollegeLoc(college: college)].departments[deptModel.getDeptLoc(college: college, deptId: id)].follow.contains(item), id: id, notificationTurnedOn: $notificationTurnedOn).environmentObject(deptModel)
                
          }
          
    }
}


//
//  TagListView.swift
//  snuboard
//
//  Created by Subeen Park on 2021/06/25.
//

import SwiftUI

struct FeedTagListView: View {
    
    @EnvironmentObject var deptModel: DepartmentViewModel
    
    let id: Int
    let college: String


    init (id: Int, college: String) {

        self.id = id
        self.college = college

    }
    
    
    var body: some View {
        
        FlexibleView(
            data: deptModel.colleges[deptModel.getCollegeLoc(college: college)].departments[deptModel.getDeptLoc(college: college, deptId: id)].tags,
            spacing: 8,
                alignment: .leading
              )  { item in
            TagChipView(item: item, selected: deptModel.colleges[deptModel.getCollegeLoc(college: college)].departments[deptModel.getDeptLoc(college: college, deptId: id)].follow.contains(item),
            actionIfSelected: {
                deptModel.createDepartmentFollow(id: id, follow: item)
            }, actionIfUnselected: {
                deptModel.deleteDepartmentFollow(id: id, follow: item)
            })
                
          }
          
    }
}

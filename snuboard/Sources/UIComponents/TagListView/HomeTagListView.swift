//
//  HomeTagListView.swift
//  snuboard
//
//  Created by Subeen Park on 2021/09/10.
//

import SwiftUI

struct HomeTagListView: View {
    
    @EnvironmentObject var settings: Settings
    @EnvironmentObject var deptModel: DepartmentViewModel
    
    let id: Int
    let dept: String
    var deptTags: [String]
    
    init(id: Int, dept: String, deptTags:[String]) {
        self.id = id
        self.dept = dept
        self.deptTags = deptTags
    }
    
    var body: some View {
        FlexibleView(
            data: deptTags,
            spacing: 5,
                alignment: .leading
              )  { item in
            
            HomeTagChipView(id: id, dept: dept, item: item, action: {
                let finalTags = UserDefaults.standard.queryParameters[dept] ?? []
                deptModel.initModelWithDepartmentId(id: id, tags: finalTags.isEmpty ? self.deptTags : finalTags)
            })
                .environmentObject(settings)
                .environmentObject(deptModel)
                
          }
    }
}

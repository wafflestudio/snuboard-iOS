//
//  DepartmentDetailView.swift
//  snuboard
//
//  Created by Subeen Park on 2021/06/25.
//

import SwiftUI

struct DepartmentDetailView: View {
    
    @EnvironmentObject var deptModel: DepartmentViewModel
    
    
    var dept: Department
    @State var indexSelected: Int = 0
    
    init (department: Department) {
        self.dept = department
        UINavigationBar.appearance().backgroundColor = .white
    }

    
    var body: some View {
        
        
        VStack(spacing: 0) {
            
            SegmentedPickerView(selectedIndex: $indexSelected)
            if (indexSelected == 0) {
//                TagListView()
                DepartmentDetailHomeView(dept: dept).environmentObject(deptModel)
            }
            else if (indexSelected == 1) {
                DepartmentDetailFeedView(dept: dept).environmentObject(deptModel)
            }
            Spacer()
        }
        .background(Const.ColorSet.BgGray.color.edgesIgnoringSafeArea(.bottom))
        
        
    }
}

struct DepartmentDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DepartmentDetailView(department: Department(id: 1, name: "지구환경과학부", college: "자연과학대학", link: "link", tags: ["tag1", "tag2"], follow: ["tag1"]))
    }
}

//
//  DepartmentDetailView.swift
//  snuboard
//
//  Created by Subeen Park on 2021/06/25.
//

import SwiftUI

struct DepartmentDetailView: View {
    
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
                Text("index 0")
            }
            else if (indexSelected == 1) {
                DepartmentDetailFeedView(dept: dept)
            }
            Spacer()
        }
        
        
    }
}

struct DepartmentDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DepartmentDetailView(department: Department(id: 1, name: "지구환경과학부", college: "자연과학대학", link: "link", tags: ["tag1", "tag2"], follow: ["tag1"]))
    }
}

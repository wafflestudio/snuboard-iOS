//
//  DepartmentDetailView.swift
//  snuboard
//
//  Created by Subeen Park on 2021/06/25.
//

import SwiftUI

struct DepartmentDetailView: View {
    
    @EnvironmentObject var deptModel: DepartmentViewModel
    
    
    var id: Int
    var dept: Department {
        deptModel.depts.first { $0.id == id}!
    }
    @State var indexSelected: Int = 0
    
    init (id: Int) {
        self.id = id
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
        DepartmentDetailView(id: 1)
    }
}

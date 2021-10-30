//
//  DepartmentSummaryView.swift
//  snuboard
//
//  Created by Subeen Park on 2021/09/10.
//

import SwiftUI
struct DepartmentSummaryView: View {
    
    @EnvironmentObject var deptModel: DepartmentListViewModel
    @EnvironmentObject var settings: Settings
    
    
    var dept: Department
    
    init(dept: Department) {
        self.dept = dept
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            NavigationLink(
                destination: DepartmentView(dept: dept)
                    .environmentObject(deptModel)
                    .environmentObject(settings)
                    ,
                label: {
                    HStack {
                        Text(dept.name)
                            .font(.system(size: 13))
                            .bold()
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        Image("navigate_next")
                            .resizable()
                            .renderingMode(/*@START_MENU_TOKEN@*/.template/*@END_MENU_TOKEN@*/)
                            .foregroundColor(.white)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 16)
                            }
                
            }) // End of Navigation Link Label
                
            .padding(8)
            .background(Color(UserDefaults.standard
                                .deptColor[dept.name] ?? Const.Colors.color_palette[0]).cornerRadius(8, corners: [.topLeft, .topRight]))
            
            
    
            FlexibleView(data: dept.follow, spacing: 5, alignment: .leading) { item in
                DepartmentTagChipView(item: item, isDept: false)
            }
            .padding(10)
            .background(Color.white).cornerRadius(8, corners: [.bottomLeft, .bottomRight])
        } // End of Vstack
    }
}

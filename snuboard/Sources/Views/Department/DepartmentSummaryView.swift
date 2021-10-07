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
    
    var id: Int = 0
    var dept: String {
        let department = deptModel.depts.first(where: {$0.id == id})
        return department?.name ?? ""
    }
    var tags: [String] {
        let department = deptModel.depts.first(where: {$0.id == id})
        return department?.follow ?? []
    }
    
    init (id: Int) {
        self.id = id
    }
    
    var deptObject: Department {
        deptModel.depts.first(where: {$0.id == id})!
    }
    
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            NavigationLink(
                destination: DepartmentDetailView(dept: deptObject)
                    .environmentObject(deptModel)
                    .environmentObject(settings)
                    ,
                label: {
                    HStack {
                        Text(dept)
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
                                .deptColor[dept] ?? Const.Colors.color_palette[0]).cornerRadius(8, corners: [.topLeft, .topRight]))
            
            
    
            FlexibleView(data: tags, spacing: 5, alignment: .leading) { item in
                DepartmentTagChipView(item: item, isDept: false)
            }
            .padding(10)
            .background(Color.white).cornerRadius(8, corners: [.bottomLeft, .bottomRight])
        } // End of Vstack
    }
}

//
//  DepartmentSummaryView.swift
//  snuboard
//
//  Created by Subeen Park on 2021/07/01.
//

import SwiftUI

struct DepartmentSummaryView: View {
    
    @EnvironmentObject var deptModel: DepartmentViewModel
    
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
    
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text(dept)
                    .font(.system(size: 12))
                    .bold()
                    .foregroundColor(.white)
                
                Spacer()
                NavigationLink(
                    destination: DepartmentDetailView(id: id).environmentObject(deptModel),
                    label: {
                        Image("navigate_next")
                            .resizable()
                            .renderingMode(/*@START_MENU_TOKEN@*/.template/*@END_MENU_TOKEN@*/)
                            .foregroundColor(.white)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 16)
                    })
                
            }
            .padding(8)
            .background(Color(UserDefaults.standard.deptColor[dept]!).cornerRadius(8, corners: [.topLeft, .topRight]))
            
            
    
            FlexibleView(data: tags, spacing: 10, alignment: .leading) { item in
                DepartmentTagChipView(item: item, isDept: false)
            }
            .padding(10)
            .background(Color.white).cornerRadius(8, corners: [.bottomLeft, .bottomRight])
        } // End of Vstack
        .hideNavigationBar()
    }
}

struct DepartmentSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        DepartmentSummaryView(id: 3)
    }
}

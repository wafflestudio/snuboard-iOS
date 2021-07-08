//
//  DepartmentHomeView.swift
//  snuboard
//
//  Created by Subeen Park on 2021/06/25.
//

import SwiftUI

struct DepartmentDetailHomeView: View {
    
    @StateObject var model: DepartmentNoticeViewModel
    @EnvironmentObject var deptModel: DepartmentViewModel

    var dept: Department
    
    init(dept: Department) {
        self.dept = dept
        _model = StateObject(wrappedValue: DepartmentNoticeViewModel(id: dept.id))
    }
    
    var body: some View {
       
        VStack {
            // Follow-Chip
            VStack {
                HStack {
                    Image("home")
                        .resizable()
                        .frame(width: 20, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    Text("태그 필터")
                        .foregroundColor(Const.ColorSet.Gray1.color)
                        .font(.system(size: 16))
                        .bold()
                    Spacer()
                }
//                TagListView(id: dept.id, tagList: dept.tags, followList: [])
            }
            .padding(12)
            .background(RoundedRectangle(cornerRadius: 8).foregroundColor(.white))
            
        
            
            // Palette-Chip
            ScrollView {
                VStack {
                    ForEach(model.notices) { noticeSummary in
                        NoticeSummaryView(notice: noticeSummary)
                    }
                }
            }
            
            
        }
        .padding(10)
        .background(Const.ColorSet.BgGray.color.ignoresSafeArea())
        
        
        
    }
}

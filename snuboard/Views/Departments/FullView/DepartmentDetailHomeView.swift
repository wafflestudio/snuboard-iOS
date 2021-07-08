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
    @EnvironmentObject var settings: Settings

    var dept: Department
    
    init(dept: Department) {
        self.dept = dept
        _model = StateObject(wrappedValue: DepartmentNoticeViewModel(id: dept.id))
    }
    
    var body: some View {
       
        VStack {
            // Follow-Chip
            TagFilterView(dept: dept.name, tags: dept.tags)
            .environmentObject(settings)
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

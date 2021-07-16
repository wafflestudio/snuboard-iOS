//
//  DepartmentHomeView.swift
//  snuboard
//
//  Created by Subeen Park on 2021/06/25.
//

import SwiftUI

struct DepartmentDetailHomeView: View {
    
    @EnvironmentObject var noticeModel: NoticeViewModel
    @EnvironmentObject var deptModel: DepartmentViewModel
    @EnvironmentObject var settings: Settings
    @Environment(\.presentationMode) var presentationMode

    var dept: Department
    
    init(dept: Department) {
        self.dept = dept
//        _noticeModel = StateObject(wrappedValue: NoticeViewModel(id: dept.id, type: .department))
    }
    
    var body: some View {
        
        VStack {
            // Follow-Chip
            TagFilterView(deptId: dept.id, deptName: dept.name, tags: dept.tags)
                .environmentObject(settings)
                .padding(12)
                .background(RoundedRectangle(cornerRadius: 8).foregroundColor(.white))
            

            ScrollView {
                VStack {
                    ForEach(noticeModel.notices) { noticeSummary in
                        NoticeSummaryView(notice: noticeSummary, isFavourite: false).environmentObject(noticeModel)
                    }
                }
            }
            
            
        }
        .padding(10)
        .background(Const.ColorSet.BgGray.color.ignoresSafeArea())
        .navigationBarTitle(dept.name, displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Image("navigate_before").onTapGesture {
                    presentationMode.wrappedValue.dismiss()
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack {
                    if let url = URL(string: dept.link) {
                        Link(destination: url, label: {
                                Image("link")
                                    .renderingMode(.template)
                                    .foregroundColor(Const.ColorSet.Gray2.color)
                                    .frame(width: 24, height: 24, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        })
                    } else {
                        Image("link")
                            .renderingMode(.template)
                            .foregroundColor(Const.ColorSet.Gray2.color)
                            .frame(width: 24, height: 24, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }
                    
                    HStack {
                        Text("")
                        NavigationLink(destination: DepartmentSearchView(dept: dept).environmentObject(settings)) {
                            Image("search")
                        }
                    }
                }
            }
        }
        
        
        
    }
}

//
//  DepartmentSearchView.swift
//  snuboard
//
//  Created by Subeen Park on 2021/07/17.
//

import SwiftUI

struct DepartmentSearchView: View {
    
    @StateObject var noticeModel = NoticeViewModel()
    @EnvironmentObject var settings: Settings
    @State var searchText = ""
    var dept: Department
    
    init(dept: Department) {
        self.dept = dept
    }
    


    
    var body: some View {
        
        ZStack {
            VStack {
                Spacer()
                    .frame(height: 44)
                ScrollView {
                    
                    VStack {
                        ForEach(noticeModel.notices) { noticeSummary in
                            NoticeSummaryView(notice: noticeSummary, isFavourite: false).environmentObject(noticeModel)
                        }
                    }.padding([.top, .leading, .trailing], 10)
                }
                
            }
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .topLeading
              )
            .background(Const.ColorSet.BgGray.color)
            VStack(spacing: 0) {
                SearchBar(searchText: $searchText, action: {
                            noticeModel.searchNoticesWithDepartmentId(id: dept.id, tags: settings.queryParameters[dept.name] ?? [], keywords: searchText)})
                Divider().background(Const.ColorSet.Gray5.color)
                Spacer()
            }
        }.hideNavigationBar()
    }
}

//
//  NoticeDetailView.swift
//  snuboard
//
//  Created by Subeen Park on 2021/07/09.
//

import SwiftUI
import WebKit

struct NoticeDetailView: View {
    
    @StateObject var noticeModel: NoticeDetailViewModel
    @Environment(\.presentationMode) var presentationMode
    
    init(id: Int) {
        _noticeModel = StateObject(wrappedValue: NoticeDetailViewModel(id: id))
        UINavigationBar.appearance().backgroundColor = .white
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(noticeModel.notice.title)
                    .font(.system(size: 16))
                    .foregroundColor(Const.ColorSet.Gray2.color)
                    .bold()
                NoticeTagListView(dept: noticeModel.notice.departmentName, tags: noticeModel.notice.tags)
                HTMLStringView(htmlContent: noticeModel.notice.content)
                HStack{
                    Spacer()
                    Text(noticeModel.notice.createdAt.asDate())
                        .font(.system(size: 12))
                        .foregroundColor(Const.ColorSet.Unselected.color)
                }
            }.padding()
        }.customNavBarWithOutSearch(title: "", action: {
            presentationMode.wrappedValue.dismiss()
        })
        
    }
}

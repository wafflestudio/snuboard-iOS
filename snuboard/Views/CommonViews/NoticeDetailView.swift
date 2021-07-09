//
//  NoticeDetailView.swift
//  snuboard
//
//  Created by Subeen Park on 2021/07/09.
//

import SwiftUI
import WebKit
import AttributedText

struct NoticeDetailView: View {
    
    @StateObject var noticeModel: NoticeDetailViewModel
    
    init(id: Int) {
        _noticeModel = StateObject(wrappedValue: NoticeDetailViewModel(id: id))
    }
    
    var body: some View {
        VStack {
            Text(noticeModel.notice.title)
            NoticeTagListView(dept: noticeModel.notice.departmentName, tags: noticeModel.notice.tags)
            HTMLStringView(htmlContent: noticeModel.notice.content)

            
        }
    }
}

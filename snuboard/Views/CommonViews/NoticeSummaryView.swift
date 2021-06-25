//
//  NoticeSummaryView.swift
//  snuboard
//
//  Created by Subeen Park on 2021/06/25.
//

import SwiftUI

struct NoticeSummaryView: View {
    
    var notice: NoticeSummary
    
    init (notice: NoticeSummary) {
        self.notice = notice
    }
    
    var body: some View {
        
       
        
        // Title
        VStack(alignment: .leading, spacing: 8) {
            
            // TagList
//            TagListView(id: notice.departmentID, college: <#String#>, tagList: notice.tags, followList: [])
            
            
            HStack {
                Text(notice.title)
                    .font(.system(size: 16))
                    .foregroundColor(Const.ColorSet.Gray2.color)
                    .bold()
            }
            HStack {
                Text(notice.preview)
                    .font(.system(size: 12))
                    .foregroundColor(Const.ColorSet.Gray3.color)
                    .lineLimit(3)
            }
            
            HStack {
                Text("\(notice.createdAt.substring(from: 2, to: 3))/\(notice.createdAt.substring(from: 5, to: 6))/\(notice.createdAt.substring(from: 8, to: 9))")
                    .font(.system(size: 12))
                    .foregroundColor(Const.ColorSet.Unselected.color)
                Spacer()
            }
        }
        .padding(12)
        .background(RoundedRectangle(cornerRadius: 8).foregroundColor(.white))
        
        
        // Preview
        
        // TimeStamp + Saved
    }
}

struct NoticeSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        NoticeSummaryView(notice: NoticeSummary(id: 1, title: "title", createdAt: "2021-04-01T06:48:00.000Z", isPinned: false, link: "link", isScrapped: true, preview: "previewpreviewpreview", departmentID: 2, departmentName: "컴퓨터공학부", tags: ["tag1", "tag2"]))
    }
}

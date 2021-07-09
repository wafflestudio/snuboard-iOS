//
//  NoticeSummaryView.swift
//  snuboard
//
//  Created by Subeen Park on 2021/06/25.
//

import SwiftUI

struct NoticeSummaryView: View {
    
    
    @EnvironmentObject var noticeModel: NoticeViewModel
    
    var notice: NoticeSummary

    
    init (notice: NoticeSummary) {
        self.notice = notice
    }
    
    
    var body: some View {
        
        // Title
        VStack(alignment: .leading, spacing: 8) {
            

            NoticeTagListView(dept: notice.departmentName, tags: notice.tags)
            
            
            
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
                if notice.isScrapped {
                    Button(action: {
                        noticeModel.deleteNoticeScrap(id: notice.id)
                    }){
                        Image("favorite_selected")
                    }
                    
                } else {
                    Button(action: {
                        noticeModel.postNoticeScrap(id: notice.id)
                    }) {
                        Image("favorite_unselected")
                    }
                    
                }
            }
        }
        .padding(12)
        .background(RoundedRectangle(cornerRadius: 8).foregroundColor(.white))
        
        
        // Preview
        
        // TimeStamp + Saved
    }
}



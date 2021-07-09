//
//  NoticeSummaryView.swift
//  snuboard
//
//  Created by Subeen Park on 2021/06/25.
//

import SwiftUI
import WebKit

struct NoticeSummaryView: View {
    
    
    @EnvironmentObject var noticeModel: NoticeViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var notice: NoticeSummary
    var isFavourite: Bool

    
    init (notice: NoticeSummary, isFavourite: Bool) {
        self.notice = notice
        self.isFavourite = isFavourite
        UINavigationBar.appearance().backgroundColor = .white
    }
    
    
    var body: some View {
        
        // Title
        NavigationLink(destination: NoticeDetailView(id: notice.id)) {
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
                    Text(notice.createdAt.asDate())
                        .font(.system(size: 12))
                        .foregroundColor(Const.ColorSet.Unselected.color)
                    Spacer()
                    if notice.isScrapped {
                        Button(action: {
                            noticeModel.deleteNoticeScrap(id: notice.id, isFavouriteList: isFavourite)
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
        }
        
        
        // Preview
        
        // TimeStamp + Saved
    }
}



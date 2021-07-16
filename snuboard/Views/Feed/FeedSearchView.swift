//
//  FeedSearchView.swift
//  snuboard
//
//  Created by Subeen Park on 2021/07/16.
//

import SwiftUI


struct FeedSearchView: View {
    
    @StateObject var noticeModel = NoticeViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State var searchText = ""
    


    
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
                    noticeModel.searchNoticesByFollowingTags(keywords: searchText)
                })
                Divider().background(Const.ColorSet.Gray5.color)
                Spacer()
            }
        }.hideNavigationBar()
    }
}

struct FeedSearchView_Previews: PreviewProvider {
    static var previews: some View {
        FeedSearchView()
    }
}

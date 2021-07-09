//
//  FeedListView.swift
//  snuboard
//
//  Created by Subeen Park on 2021/07/09.
//

import SwiftUI

struct FeedListView: View {
    
    init() {
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
    }
    
    @ObservedObject var noticeModel: NoticeViewModel = NoticeViewModel(type: .follow)
    var body: some View {
        
        NavigationView {
            VStack(spacing: 0) {
                if noticeModel.notices.isEmpty {
                    PlaceHolderView()
                }
                else {
                    ScrollView {
                        VStack {
                            ForEach(noticeModel.notices) { noticeSummary in
                                NoticeSummaryView(notice: noticeSummary, isFavourite: false).environmentObject(noticeModel)
                            }
                        }.padding([.top, .leading, .trailing], 10)
                        .background(Const.ColorSet.BgGray.color)
                    }
                }
            }
            .navigationBarTitle("", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Image("logo_horizontal")
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Image("menu")
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Image("search")
                }
            }.padding(.top, 1)
        }.onAppear {
            noticeModel.getNoticesByFollow()
        }
        
        
        
        

    }
}

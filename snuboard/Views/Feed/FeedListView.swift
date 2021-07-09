//
//  FeedListView.swift
//  snuboard
//
//  Created by Subeen Park on 2021/07/09.
//

import SwiftUI

struct FeedListView: View {
    
    @ObservedObject var noticeModel: NoticeViewModel = NoticeViewModel(type: .follow)
    var body: some View {
        
        NavigationView {
            if noticeModel.notices.isEmpty {
                ZStack {
                    PlaceHolderView()
                    VStack(spacing: 0) {
                        LogoTopBar()
                        Divider()
                        Spacer()
                        
                    }
                }
                .navigationBarTitle("", displayMode: .inline)
                .navigationBarHidden(true)
            }
            else {
                VStack(spacing: 0){
                    
                    LogoTopBar()
                    Divider()
                    ScrollView {
                        VStack {
                            ForEach(noticeModel.notices) { noticeSummary in
                                NoticeSummaryView(notice: noticeSummary, isFavourite: true).environmentObject(noticeModel)
                            }
                        }.padding(10)
                    }
                    .background(Const.ColorSet.BgGray.color)
                    Spacer()
                }
                .navigationBarTitle("", displayMode: .inline)
                .navigationBarHidden(true)
            }
            
        }
        
        
        
        

    }
}




//
//var body: some View {
//    NavigationView {
//        VStack(spacing: 0) {
//            ScrollView {
//                VStack {
//                    ForEach(noticeModel.notices) { noticeSummary in
//                        NoticeSummaryView(notice: noticeSummary, isFavourite: true).environmentObject(noticeModel)
//                    }
//                }.padding(10)
//            }
//            .background(Const.ColorSet.BgGray.color)
//        }
//        .navigationBarTitle("", displayMode: .inline)
//        .navigationBarHidden(true)
//    }.onAppear {
//        noticeModel.getAllNoticesScrapped()
//    }

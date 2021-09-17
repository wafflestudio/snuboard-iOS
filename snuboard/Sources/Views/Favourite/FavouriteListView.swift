//
//  FavouriteListView.swift
//  snuboard
//
//  Created by Subeen Park on 2021/09/14.
//

import SwiftUI

struct FavouriteListView: View {
    
    init() {
//        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().backgroundColor = .white
    }
    
    @StateObject var noticeModel = NoticeViewModel(type: .scrap)
    @EnvironmentObject var settings: Settings
    
    var body: some View {
            VStack(spacing: 0) {
                if noticeModel.notices.filter { $0.isScrapped }.isEmpty {
                    PlaceHolderView("favourite_placeholder")
                }
                else {
                    ScrollView {
                        VStack {
                            ForEach(noticeModel.notices.filter { $0.isScrapped }) { noticeSummary in
                                NoticeSummaryView(notice: noticeSummary).environmentObject(noticeModel)
                            }
                            if !noticeModel.noMoreContent {
                                HStack { // Load more Hstack
                                    Spacer()
                                    HStack {
                                        Button(action: {
                                            noticeModel.loadMoreScrappedNotices()

                                        }, label: {
                                            Text("더보기")
                                                .foregroundColor(Const.Colors.MainBlue.color)
                                                .font(.system(size: 12))
                                        })
                                        
                                    }
                                    Spacer()
                                } // end of load more Hstack
                            }
                            
                        }.padding(10)
                    }
                    .padding(.top, 1)
                    .background(Const.Colors.BgGray.color)
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .onAppear {
                noticeModel.getScrappedNotices()
            }
            
        
    }
}

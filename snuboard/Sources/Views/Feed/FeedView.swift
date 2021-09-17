//
//  FeedView.swift
//  snuboard
//
//  Created by Subeen Park on 2021/09/03.
//

import SwiftUI

struct FeedView: View {
    
    @EnvironmentObject var envModel: EnvModel
    @StateObject var noticeModel = NoticeViewModel(type: .follow)
    
    var body: some View {
        
        VStack(spacing: 0) {
            if noticeModel.notices.isEmpty {
                PlaceHolderView("feed_placeholder")
            }
            else {
                ScrollView {
                    VStack {
                        ForEach(noticeModel.notices) { noticeSummary in
                            NoticeSummaryView(notice: noticeSummary).environmentObject(noticeModel)
                        }
                        if !noticeModel.noMoreContent {
                            HStack { // Load more Hstack
                                Spacer()
                                HStack {
                                    Button(action: {
                                        noticeModel.loadMoreFollowingNotices()

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
                } // End of scroll view
                .padding(.top, 1)
                .background(Const.Colors.BgGray.color)
            }
        }
        .onAppear {
            noticeModel.getNoticesByFollow()
        }
        
 

        

    
    }

}

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
    @ObservedObject var appState = AppState.shared
    
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            if noticeModel.notices.isEmpty && !noticeModel.loading {
                PlaceHolderView("feed_placeholder")
            }
            else {
                
                ScrollView {
                    VStack {
                        ForEach(noticeModel.notices) { noticeSummary in
                            
    //                        NavigationLink(destination: NoticeSummaryView(notice: noticeSummary).environmentObject(noticeModel), isActive: $isShowingDetailView) { EmptyView() }
                            
                            NavigationLink(
                                destination: NoticeDetailView(id: noticeSummary.id).environmentObject(noticeModel),
                                isActive: .constant(appState.pageToNavigationTo==noticeSummary.id),
                                label: {
                                    NoticeSummaryView(notice: noticeSummary)
                                        .environmentObject(noticeModel)
                                        .onTapGesture {
                                            appState.pageToNavigationTo = noticeSummary.id
                                        }
                                })
                            
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
                                            .font(.system(size: 14))
                                    })
                                    
                                }
                                Spacer()
                            } // end of load more Hstack
                        }
                        
                    }.padding(10)
                    if noticeModel.loading {
                        HStack {
                            Spacer()
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle())
                            Spacer()
                        }
                    }
                } // End of scroll view
                .padding(.top, 1)
                .background(Const.Colors.BgGray.color)
                
            }

        }
        .onChange(of: envModel.refreshTab, perform: { newVal in
            print("Recieve refresh tab change \(newVal)")
            if newVal {
                noticeModel.getNoticesByFollow()
                envModel.refreshTab = false
            }
        })

    
    }

}

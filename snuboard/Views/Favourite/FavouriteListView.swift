//
//  FavouriteListView.swift
//  snuboard
//
//  Created by Subeen Park on 2021/07/09.
//

import SwiftUI
import WebKit

struct FavouriteListView: View {
    
    @ObservedObject var noticeModel: NoticeViewModel = NoticeViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                TopBar("관심목록")
                Divider()
                ScrollView {
                    VStack {
                        ForEach(noticeModel.notices) { noticeSummary in
                            NoticeSummaryView(notice: noticeSummary).environmentObject(noticeModel)
                        }
                    }.padding(10)
                }
                .background(Const.ColorSet.BgGray.color)
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
        }.onAppear {
            noticeModel.getAllNoticesScrapped()
        }
        
        
    }
}

struct FavouriteListView_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteListView()
    }
}

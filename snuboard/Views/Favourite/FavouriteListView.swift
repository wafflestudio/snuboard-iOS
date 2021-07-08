//
//  FavouriteListView.swift
//  snuboard
//
//  Created by Subeen Park on 2021/07/09.
//

import SwiftUI

struct FavouriteListView: View {
    
    @ObservedObject var noticeModel: NoticeViewModel = NoticeViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            TopBar("관심목록")
            Divider()
            ScrollView {
                VStack {
                    ForEach(noticeModel.notices) { noticeSummary in
                        NoticeSummaryView(id: noticeSummary.id).environmentObject(noticeModel)
                    }
                }.padding(10)
            }
            .background(Const.ColorSet.BgGray.color)
            
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
//
//  FavouriteListView.swift
//  snuboard
//
//  Created by Subeen Park on 2021/07/09.
//

import SwiftUI
import WebKit

struct FavouriteListView: View {
    
    init() {
//        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().backgroundColor = .white
    }
    
    @ObservedObject var noticeModel: NoticeViewModel = NoticeViewModel(type: .scrap)
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                if noticeModel.notices.isEmpty {
                    PlaceHolderView("favourite_placeholder")
                }
                else {
                    ScrollView {
                        VStack {
                            ForEach(noticeModel.notices) { noticeSummary in
                                NoticeSummaryView(notice: noticeSummary, isFavourite: true).environmentObject(noticeModel)
                            }
                        }.padding(10)
                    }
                    .background(Const.ColorSet.BgGray.color)
                }
            }
            .navigationBarTitle("", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("관심목록")
                        .font(.system(size: 20))
                        .bold()
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Image("menu")
                        .frame(width: 24, height: 24, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }
                
            }
            .padding(.top, 1)
            .navigationViewStyle(StackNavigationViewStyle())
            
//            .navigationBarHidden(true)
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

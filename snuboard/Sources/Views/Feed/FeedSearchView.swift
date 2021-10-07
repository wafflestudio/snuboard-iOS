//
//  FeedSearchView.swift
//  snuboard
//
//  Created by Subeen Park on 2021/09/14.
//

import SwiftUI

struct FeedSearchView: View {
    
    @StateObject var noticeModel = NoticeViewModel(type: .follow)
    @Environment(\.presentationMode) var presentationMode
    @State var searchText = ""
    @State var showAlert = false
    
    
    var body: some View {
        
        ZStack {
            VStack {
                Spacer()
                    .frame(height: 44)
                if noticeModel.notices.isEmpty && noticeModel.nextCursor == "" {
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Image("search_placeholder")
                                .resizable()
                                .frame(width: 203, height: 203, alignment: .center)
                            Spacer()
                        }
                        
                        Spacer().frame(height: 22)
                    }
                }
                else {
                    ScrollView {
                        
                        VStack {
                            ForEach(noticeModel.notices) { noticeSummary in
                                NoticeSummaryView(notice: noticeSummary).environmentObject(noticeModel)
                            }
                        }.padding([.top, .leading, .trailing], 10)
                    }
                }
                
                
            }
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .topLeading
              )
            .background(Const.Colors.BgGray.color)
            VStack(spacing: 0) {
                SearchBar(searchText: $searchText,
                          action: {
                            if searchText.count < 2 {
                                self.showAlert = true
                            } else {
                                noticeModel.searchNoticesWithFollow(keywords: searchText)
                            }
                          },
                          dismissAction: {
                            self.presentationMode.wrappedValue.dismiss()
                          })
                
               
                Divider().background(Const.Colors.Gray5.color)
                Spacer()
            }
        } // End of ZStack
        .edgesIgnoringSafeArea(.bottom)
        .hideNavigationBar()
        .alert(isPresented: $showAlert, content: {
            Alert(title: Text("검색"), message: Text("각 단어의 길이는 두 글자 이상이어야 합니다."), dismissButton: .default(Text("확인")))
        })
    }
}

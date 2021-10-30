//
//  NoticeDetailView.swift
//  snuboard
//
//  Created by Subeen Park on 2021/09/10.
//

import SwiftUI
import WebKit

struct NoticeDetailView: View {
    
    @StateObject var noticeModel: NoticeDetailViewModel
    @EnvironmentObject var noticeSummaryModel: NoticeViewModel
    @Environment(\.presentationMode) var presentationMode
    

    init(id: Int) {
        _noticeModel = StateObject(wrappedValue: NoticeDetailViewModel(id: id))
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
    }
    
    var body: some View {
        
        VStack {
            
            if noticeModel.loading {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                        Spacer()
                    }
                    Spacer()
                }
            }
            
            else {
                VStack {
                    VStack(alignment: .leading) {
                        Text(noticeModel.notice.title)
                            .font(.system(size: 18))
                            .foregroundColor(Color.black)
                            .bold()
                        NoticeTagListView(dept: noticeModel.notice.departmentName, tags: noticeModel.notice.tags)
                        HTMLView(htmlContent: noticeModel.notice.content)
                        HStack{
                            Spacer()
                            Text(noticeModel.notice.createdAt.asDate())
                                .font(.system(size: 12))
                                .foregroundColor(Const.Colors.Unselected.color)
                        }
                    }
                    .padding(20)
                    .background(Color.white)
                    
                    Spacer()
                        .frame(height: 10)
                    
                    VStack{
                        
                        HStack {
                            
                            HStack {
                                Image("folder_open")
                                    .frame(width: 16, height: 16, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                Text("첨부파일")
                                    .font(.system(size: 14))
                                Spacer()
                            }
                            
                        }
                        
                        VStack {
                            ForEach(noticeModel.notice.files) { file in
                                Link(destination: URL(string: file.link)!, label: {
                                        HStack {
                                            Image("file_copy")
                                                .frame(width: 16, height: 16, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                            Text(file.name)
                                                .foregroundColor(Const.Colors.Gray2.color)
                                                .font(.system(size: 12))
                                            
                                            Spacer()
                                        }
                                        
                                    })
                            }
                        }
                    }
                    .padding(20)
                    .background(Color.white)
                    
                }
                .background(Const.Colors.BgGray.color)
                .padding(.top, 1)
            }
            
        }
        .onAppear {
            noticeModel.getNotice()
            print("NoticeModel GetNotice")
            AppState.shared.pageToNavigationTo = nil
            print("PageToNavigationTo = nil")
        }    
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack {
                    if let url = URL(string: noticeModel.notice.link) {
                        Link(destination: url, label: {
                                Image("link")
                                    .renderingMode(.template)
                                    .foregroundColor(Const.Colors.Gray2.color)
                                    .frame(width: 24, height: 24, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        })
                    } else {
                        Image("link")
                            .renderingMode(.template)
                            .foregroundColor(Const.Colors.Gray2.color)
                            .frame(width: 24, height: 24, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }
                

                    if noticeModel.notice.isScrapped {
                        Button(action: {
                            noticeModel.deleteNoticeScrap(id: noticeModel.notice.id)
                            noticeSummaryModel.deleteNoticeScrap(id: noticeModel.notice.id)
                        }, label: {
                            Image("favorite_selected")
                                .resizable()
                                .frame(width: 24, height: 24, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        })
                    } else {
                        Button(action: {
                            noticeModel.createNoticeScrap(id: noticeModel.notice.id)
                            noticeSummaryModel.createNoticeScrap(id: noticeModel.notice.id)
  
                        }, label: {
                            Image("favorite_unselected")
                                .renderingMode(/*@START_MENU_TOKEN@*/.template/*@END_MENU_TOKEN@*/)
                                .resizable()
                                .frame(width: 24, height: 24, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .foregroundColor(Const.Colors.Gray2.color)
                        })
                    }
                    
                }
                
                
            }
        }
        .customNavBarWithOutSearch(title: "", action: {
            presentationMode.wrappedValue.dismiss()
        })
        
    }
}

//
//  NoticeDetailView.swift
//  snuboard
//
//  Created by Subeen Park on 2021/07/09.
//

import SwiftUI
import WebKit

struct NoticeDetailView: View {
    
    @StateObject var noticeModel: NoticeDetailViewModel
    @Environment(\.presentationMode) var presentationMode
    
    init(id: Int) {
        _noticeModel = StateObject(wrappedValue: NoticeDetailViewModel(id: id))
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
    }
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text(noticeModel.notice.title)
                    .font(.system(size: 16))
                    .foregroundColor(Const.ColorSet.Gray2.color)
                    .bold()
                NoticeTagListView(dept: noticeModel.notice.departmentName, tags: noticeModel.notice.tags)
                HTMLStringView(htmlContent: noticeModel.notice.content)
                HStack{
                    Spacer()
                    Text(noticeModel.notice.createdAt.asDate())
                        .font(.system(size: 12))
                        .foregroundColor(Const.ColorSet.Unselected.color)
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
                                        .foregroundColor(Const.ColorSet.Gray2.color)
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
        .background(Const.ColorSet.BgGray.color)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack {
                    if let url = URL(string: noticeModel.notice.link) {
                        Link(destination: url, label: {
                                Image("link")
                                    .frame(width: 24, height: 24, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        })
                    } else {
                        Image("link")
                            .frame(width: 24, height: 24, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }
                

                    if noticeModel.notice.isScrapped {
                        Button(action: {
                            
                        }, label: {
                            Image("favorite_selected")
                        })
                    } else {
                        Button(action: {
                            
                        }, label: {
                            Image("favorite_unselected")
                                .renderingMode(/*@START_MENU_TOKEN@*/.template/*@END_MENU_TOKEN@*/)
                                .foregroundColor(Const.ColorSet.Gray2.color)
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

//
//  DeptNoticeSummaryView.swift
//  snuboard
//
//  Created by Subeen Park on 2021/10/29.
//


import SwiftUI
import WebKit

struct DeptNoticeSummaryView: View {
    
    
    @EnvironmentObject var deptModel: DepartmentViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var notice: NoticeSummary
    
    init (notice: NoticeSummary) {
        self.notice = notice
//        UINavigationBar.appearance().backgroundColor = .white
    }
    
    
    var body: some View {
        
        // Title
        
        NavigationLink(destination: DeptNoticeDetailView(id: notice.id).environmentObject(deptModel)) {
            VStack(alignment: .leading, spacing: 8) {
                
                NoticeTagListView(dept: notice.departmentName, tags: notice.tags)
                
                
                HStack {
                    Text(notice.title)
                        .font(.system(size: 16))
                        .foregroundColor(Color.black)
                        .bold()
                        .multilineTextAlignment(.leading)
                }
                HStack {
                    Text(notice.preview)
                        .font(.system(size: 12))
                        .foregroundColor(Color.black)
                        .lineLimit(2)
                        .frame(alignment: .leading)
                        .multilineTextAlignment(.leading)
                }
                
                HStack {
                    Text(notice.createdAt.asDate())
                        .font(.system(size: 12))
                        .foregroundColor(Const.Colors.Unselected.color)
                    Spacer()
                    if notice.isScrapped {
                        Button(action: {
                            deptModel.deleteNoticeScrap(id: notice.id)
                        }){
                            Image("favorite_selected")
                                .resizable()
                                .frame(width: 24, height: 24, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        }
                        
                    } else {
                        Button(action: {
                            deptModel.createNoticeScrap(id: notice.id)
                        }) {
                            Image("favorite_unselected")
                                .resizable()
                                .frame(width: 24, height: 24, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        }
                        
                    }
                }
            }
            .padding(12)
            .background(RoundedRectangle(cornerRadius: 8).foregroundColor(.white))
        }
        
        
        // Preview
        
        // TimeStamp + Saved
    }
}


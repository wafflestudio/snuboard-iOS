//
//  TagFilterView.swift
//  snuboard
//
//  Created by Subeen Park on 2021/07/09.
//

import SwiftUI

struct TagFilterView: View {
    
    @EnvironmentObject var settings: Settings
    @EnvironmentObject var noticeModel: NoticeViewModel
    
    var deptId: Int
    var deptName: String
    var tags: [String]
    
    init(deptId: Int, deptName: String, tags: [String]) {
        self.deptId = deptId
        self.deptName = deptName
        self.tags = tags
    }
    
    var body: some View {
        VStack {
            HStack {
                Image("home")
                    .resizable()
                    .frame(width: 20, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                Text("태그 필터")
                    .foregroundColor(Const.ColorSet.Gray1.color)
                    .font(.system(size: 16))
                    .bold()
                Spacer()
            }
            HomeTagListView(dept: deptName, deptTags: tags).environmentObject(settings)
            HStack {
                
                Button(action: {
                    settings.queryParameters[deptName]? = []
                    }, label: {
                        Text("초기화").foregroundColor(Const.ColorSet.Gray1.color)
                            .bold()
                            .font(.system(size: 12))
                    })
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 30)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Const.ColorSet.Gray1.color, lineWidth: 1)
                    )
                
                Button(action: {
                    noticeModel.getNoticesByDepartmentId(id: deptId, tags: settings.queryParameters[deptName] ?? [])
                }, label: {
                    Text("필터 적용")
                        .bold()
                        .foregroundColor(.white)
                        .font(.system(size: 12))
                })
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 30)
                .background(RoundedRectangle(cornerRadius: 8).foregroundColor(Const.ColorSet.MainBlue.color))
                
            }
        }
    }
}


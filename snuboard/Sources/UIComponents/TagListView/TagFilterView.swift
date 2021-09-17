//
//  TagFilterView.swift
//  snuboard
//
//  Created by Subeen Park on 2021/09/10.
//


import SwiftUI

struct TagFilterView: View {

    @EnvironmentObject var settings: Settings
    @EnvironmentObject var noticeModel: NoticeViewModel
    @State var showAlert = false


    var deptId: Int
    var deptName: String
    var tags: [String]
    @Binding var searchText: String

    init(deptId: Int, deptName: String, tags: [String], searchText: Binding<String>) {
        self.deptId = deptId
        self.deptName = deptName
        self.tags = tags
        self._searchText = searchText 
    }

    var body: some View {
        VStack {
            HStack {
                Image("home")
                    .resizable()
                    .frame(width: 20, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                Text("태그 필터")
                    .foregroundColor(Const.Colors.Gray1.color)
                    .font(.system(size: 16))
                    .bold()
                Spacer()
            }
            HStack {
                Image("search")
                    .renderingMode(.template)
                    .foregroundColor(Const.Colors.Gray3.color)
                TextField("글 제목, 내용, 태그를 검색하세요", text: $searchText, onCommit: {
                    print("search \(self.searchText)")
                    if self.searchText.count < 2 {
                        showAlert = true
                    } else {
                        noticeModel.searchNoticesWithDepartmentId(tags: UserDefaults.standard.queryParameters[deptName] ?? [], keywords: self.searchText)
                    }
                    
                })
                    .font(.system(size: 13))
            }
            .padding([.top, .bottom], 5)
            .padding([.leading], 5)
            .background(Const.Colors.Gray5.color).cornerRadius(10)
            HomeTagListView(id: deptId, dept: deptName, deptTags: tags)
                .environmentObject(settings)
                .environmentObject(noticeModel)
        } // End of VStack
        .alert(isPresented: $showAlert, content: {
            Alert(title: Text("검색"), message: Text("각 단어의 길이는 두 글자 이상이어야 합니다."), dismissButton: .default(Text("확인")))
        })
        
    }
    
}


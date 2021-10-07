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
                    .font(.system(size: 14))
            }
            .padding([.top, .bottom], 5)
            .padding([.leading], 5)
            .background(Const.Colors.Gray5.color).cornerRadius(10)
            HomeTagListView(id: deptId, dept: deptName, deptTags: tags)
                .environmentObject(settings)
                .environmentObject(noticeModel)
            
            HStack {
                Button(action: {
                    settings.queryParameters[deptName]? = []
                    noticeModel.initModelWithDepartmentId(id: deptId, tags: tags)
                }, label: {
                    Text("필터 제거").foregroundColor(Const.Colors.Gray1.color)
                        .bold()
                        .font(.system(size: 13))
                })
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 30)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Const.Colors.Gray1.color, lineWidth: 1)
                )
                
                Button(action: {
                    if searchText.count < 2 {
                        showAlert = true
                    } else {
                        noticeModel.searchNoticesWithDepartmentId(tags: settings.queryParameters[deptName] ?? [], keywords: searchText)
                        UIApplication.shared.endEditing()
                    }
                }, label: {
                    Text("검색")
                        .bold()
                        .foregroundColor(.white)
                        .font(.system(size: 13))
                })
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 30)
                .background(RoundedRectangle(cornerRadius: 8).foregroundColor(Const.Colors.MainBlue.color))
                
            } // End of button HStack
            
            
        } // End of VStack
        .alert(isPresented: $showAlert, content: {
            Alert(title: Text("검색"), message: Text("각 단어의 길이는 두 글자 이상이어야 합니다."), dismissButton: .default(Text("확인")))
        })
        
    }
    
}


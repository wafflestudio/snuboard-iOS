//
//  SearchBar.swift
//  snuboard
//
//  Created by Subeen Park on 2021/07/17.
//

import SwiftUI


struct SearchBar: View {
    
    @Binding var searchText: String
    var action: () -> ()
    @Environment(\.presentationMode) var presentationMode
    
    init(searchText: Binding<String>, action: @escaping ()->()) {
        self._searchText = searchText
        self.action = action
    }
    
    
    
    var body: some View {
        HStack {
            HStack {
                Image("search")
                    .renderingMode(.template)
                    .foregroundColor(Const.ColorSet.Gray3.color)
                TextField("글 제목, 내용, 태그를 검색하세요", text: $searchText, onCommit: {action()})
                    .font(.system(size: 13))
            }
            .padding([.top, .bottom], 5)
            .padding([.leading], 5)
            .background(Const.ColorSet.Gray5.color).cornerRadius(10)
            Text("취소")
            .font(.system(size: 15))
            .onTapGesture {
                presentationMode.wrappedValue.dismiss()
            }
        }
        .padding([.leading, .trailing], 10)
        .frame(height: 44, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .background(Color.white)
    }
}

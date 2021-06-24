//
//  DepartmentDetailFeedView.swift
//  snuboard
//
//  Created by Subeen Park on 2021/06/25.
//

import SwiftUI

struct DepartmentDetailFeedView: View {
    
    var dept: Department
    
    init(dept: Department) {
        self.dept = dept
    }
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Image("tag")
                        .resizable()
                        .frame(width: 20, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    Text("팔로우")
                        .foregroundColor(Const.ColorSet.Gray1.color)
                        .font(.system(size: 16))
                        .bold()
                    Spacer()
                }
                TagListView(tagList: dept.tags, followList: dept.follow)
            }
            .padding(12)
            .background(RoundedRectangle(cornerRadius: 8).foregroundColor(.white))
            Spacer()
        }
        .padding(10)
        .ignoresSafeArea()
        .background(Const.ColorSet.BgGray.color)
        
    }
}

//struct DepartmentDetailFeedView_Previews: PreviewProvider {
//    static var previews: some View {
//        DepartmentDetailFeedView()
//    }
//}

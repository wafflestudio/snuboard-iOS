//
//  DepartmentDetailFeedView.swift
//  snuboard
//
//  Created by Subeen Park on 2021/06/25.
//

import SwiftUI

struct DepartmentDetailFeedView: View {
    
    @EnvironmentObject var deptModel: DepartmentViewModel
    
    var dept: Department
    var collegeId: Int = 0
    
    init(dept: Department) {
        self.dept = dept
    }
    
    var body: some View {
       
        VStack {
            
            
            // Follow-Chip
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
                FeedTagListView(id: dept.id, college: dept.college).environmentObject(deptModel)
            }
            .padding(12)
            .background(RoundedRectangle(cornerRadius: 8).foregroundColor(.white))
            
            // Palette-Chip
            VStack {
                HStack {
                    Image("color_lens")
                        .resizable()
                        .frame(width: 20, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    Text("색")
                        .foregroundColor(Const.ColorSet.Gray1.color)
                        .font(.system(size: 16))
                        .bold()
                    Spacer()
                }
                ColorPalette()
            }
            .padding(12)
            .background(RoundedRectangle(cornerRadius: 8).foregroundColor(.white))
            
            Spacer()
            
            
        }
        .padding(10)
        .background(Const.ColorSet.BgGray.color.ignoresSafeArea())
        
        
        
    }
}

//struct DepartmentDetailFeedView_Previews: PreviewProvider {
//    static var previews: some View {
//        DepartmentDetailFeedView()
//    }
//}

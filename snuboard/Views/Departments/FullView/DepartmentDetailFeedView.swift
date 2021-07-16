//
//  DepartmentDetailFeedView.swift
//  snuboard
//
//  Created by Subeen Park on 2021/06/25.
//

import SwiftUI

struct DepartmentDetailFeedView: View {
    
    @EnvironmentObject var deptModel: DepartmentViewModel
    @EnvironmentObject var settings: Settings
    @Environment(\.presentationMode) var presentationMode
    
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
                FeedTagListView(id: dept.id, college: dept.college)
                    .environmentObject(deptModel)
                    .environmentObject(settings)
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
        .navigationBarTitle(dept.name, displayMode: .inline)
        .navigationBarBackButtonHidden(true)
//        .toolbar {
//            ToolbarItem(placement: .navigationBarLeading) {
//                Image("navigate_before").onTapGesture {
//                    presentationMode.wrappedValue.dismiss()
//                }
//            }
//            ToolbarItem(placement: .navigationBarTrailing) {
//                HStack {
//                    if let url = URL(string: dept.link) {
//                        Link(destination: url, label: {
//                                Image("link")
//                                    .renderingMode(.template)
//                                    .foregroundColor(Const.ColorSet.Gray2.color)
//                                    .frame(width: 24, height: 24, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//                        })
//                    } else {
//                        Image("link")
//                            .renderingMode(.template)
//                            .foregroundColor(Const.ColorSet.Gray2.color)
//                            .frame(width: 24, height: 24, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//                    }
//                }
//            }
//        }
        
        
        
    }
}

//struct DepartmentDetailFeedView_Previews: PreviewProvider {
//    static var previews: some View {
//        DepartmentDetailFeedView()
//    }
//}

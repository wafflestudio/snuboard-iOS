//
//  CollegeViewCell.swift
//  snuboard
//
//  Created by Subeen Park on 2021/09/08.
//

import SwiftUI

struct CollegeViewCell: View {

    @EnvironmentObject var deptModel: DepartmentListViewModel
    @EnvironmentObject var settings: Settings
    
    var college: College
    @State var showDetail: Bool = false
    var animation: Animation {
        Animation.easeOut
    }
    
    init(college: College) {
        self.college = college
    }
    
    var body: some View {
        
    
            VStack(spacing: 0) {

                
                HStack {
                    Image("domain")
                        .resizable()
                        .frame(width: 20, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    Text(college.college)
                        .bold()
                        .font(.system(size: 17))
                        .foregroundColor(Const.Colors.Gray2.color)
                    Spacer()
                    ZStack() {
                        Image("arrowtriangle.forward.fill")
                            .resizable()
                            .renderingMode(/*@START_MENU_TOKEN@*/.template/*@END_MENU_TOKEN@*/)
                            .foregroundColor(Const.Colors.Gray2.color)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 8)
                            .rotationEffect(Angle.degrees(showDetail ? 90 : 0))
    //                        .animation(animation)
                        Spacer()
                            .frame(width: 30, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }
                       
                } // End of Hstack
                .contentShape(Rectangle())
                .onTapGesture {
                    showDetail.toggle()
                }
                .padding(.leading, 13)
                .padding(.trailing, 13)
                .padding(.top, 8.5)
                .padding(.bottom, 8.5)
                
                
                // Department List
                if showDetail {
                    VStack(spacing: 12) {
                        ForEach(college.departments, id: \.self) { department in
                            
                            NavigationLink(
                                destination: DepartmentView(dept: department).environmentObject(settings),
                                label: {
                                    HStack {
                                        Image("book")
                                            .resizable()
                                            .frame(width: 16 , height:16)
                                        Text(department.name)
                                            .font(.system(size: 14))
                                            .foregroundColor(.black)
                                        Spacer()
                                        Image("navigate_next")
                                            .resizable()
                                            .frame(width: 20, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    } // End of HStack
                                    .contentShape(Rectangle())
                                }) // End of NavigationLink
                            .padding(.leading, 13)
                            .padding(.trailing, 13)
                        }

                        NavigationLink(destination: EmptyView()) {
                            EmptyView()
                        }
                    }
                    .padding(.leading, 5)
                    .padding(.trailing, 5)
                    .padding(.bottom, 8.5)
                }
            
            
            
        } // End of VStack
        .background(RoundedRectangle(cornerRadius: 8).foregroundColor(.white))
        
        
        
        
    }
}



//
//  DepartmentListView.swift
//  snuboard
//
//  Created by Subeen Park on 2021/06/24.
//

import SwiftUI

struct DepartmentListView: View {
    
    @EnvironmentObject var deptModel: DepartmentViewModel
    
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
                        .font(.system(size: 16))
                        .foregroundColor(Const.ColorSet.Gray2.color)
                    Spacer()
                    ZStack() {
                        Image("arrowtriangle.forward.fill")
                            .resizable()
                            .renderingMode(/*@START_MENU_TOKEN@*/.template/*@END_MENU_TOKEN@*/)
                            .foregroundColor(Const.ColorSet.Gray2.color)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 8)
                            .rotationEffect(Angle.degrees(showDetail ? 90 : 0))
    //                        .animation(animation)
                        Spacer()
                            .frame(width: 30, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }
                    .onTapGesture {
                        showDetail.toggle()
                    }
                    
                       
                } // End of Hstack
                .padding(.leading, 13)
                .padding(.trailing, 13)
                .padding(.top, 8.5)
                .padding(.bottom, 8.5)
                
                
                // Department List
                if showDetail {
                    VStack(spacing: 12) {
                        ForEach(college.departments, id: \.self) { department in
                            HStack {
                                Image("book")
                                    .resizable()
                                    .frame(width: 16 , height:16)
                                Text(department.name)
                                    .font(.system(size: 13))
                                Spacer()
                                NavigationLink(
                                    destination: DepartmentDetailView(department: department).environmentObject(deptModel),
                                    label: {
                                        Image("navigate_next")
                                            .resizable()
                                            .frame(width: 20, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    })
                                
                            }
                            .padding(.leading, 13)
                            .padding(.trailing, 13)
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

struct DepartmentListView_Previews: PreviewProvider {
    static var previews: some View {
        DepartmentListView(college: College(college: "자연과학대학", departments: [Department(id: 1, name: "지구환경과학부", college: "자연과학대학", link: "", tags: ["hello"], follow: ["hello"])]))
    }
}

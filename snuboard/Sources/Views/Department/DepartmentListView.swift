//
//  DepartmentListView.swift
//  snuboard
//
//  Created by Subeen Park on 2021/10/28.
//

import SwiftUI

struct DepartmentListView: View {
    
    @EnvironmentObject var deptModel: DepartmentListViewModel
    @EnvironmentObject var settings: Settings
        
    var body: some View {
        VStack { // VSTACK 0
            ScrollView { // SCROLLVIEW
                VStack { // VSTACK 1
                    
                    // FOLLOWED DEPARTMENTS
                    ForEach(deptModel.colleges, id: \.self) { college in
                        ForEach(college.departments.filter({!$0.follow.isEmpty}), id: \.self) { dept in
                            DepartmentSummaryView(dept: dept)
                                .padding([.leading, .trailing], 10)
                                .environmentObject(deptModel)
                                .environmentObject(settings)
                        }

                    }
                    
                    // OTHER COLLEGES
                    ForEach(deptModel.colleges) { college in
                        Collapsible(label: {
                            Text(college.college)
                        }, content: {
                            ForEach(college.departments, id: \.self) { dept in
                                VStack {
                                    NavigationLink(destination: DepartmentView(dept: dept).environmentObject(settings), label: {
                                        
                                        HStack {
                                            Image("book")
                                                .resizable()
                                                .frame(width: 16 , height:16)
                                            Text(dept.name)
                                                .font(.system(size: 14))
                                                .foregroundColor(.black)
                                            Spacer()
                                            Image("navigate_next")
                                                .resizable()
                                                .frame(width: 20, height: 20, alignment: .center)
                                        }
                                        .contentShape(Rectangle())
                                        
                                    })
                                }
                                EmptyView()
                            }
                        }) // END OF COLLAPSIBLE
                        .padding([.leading, .trailing], 10)
                    }
                    
                } // END OF VSTACK 1
            } // END OF SCROLLVIEW
            .padding([.top, .bottom], 10)
        } // END OF VSTACK 0
        .background(Const.Colors.BgGray.color)
        .onAppear {
            deptModel.initModel()
        }
    }
    

}

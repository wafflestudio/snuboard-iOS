//
//  CollegeView.swift
//  snuboard
//
//  Created by Subeen Park on 2021/09/08.
//

import SwiftUI

struct CollegeView: View {
    
    @EnvironmentObject var deptModel: DepartmentListViewModel
    @EnvironmentObject var settings: Settings
    @EnvironmentObject var envModel: EnvModel
    
    var body: some View {
        
        ZStack {
            
            Const.Colors.BgGray.color
            
            if deptModel.loading {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                        Spacer()
                    }
                    Spacer()
                }
            }
            else {
                
                VStack(spacing: 0) {
                    ScrollView(showsIndicators: false){
                        
                        VStack(spacing: 10) {
                            
                            ForEach(deptModel.colleges, id: \.self) { college in

                                ForEach(college.departments.filter({!$0.follow.isEmpty}), id: \.self) { dept in
                                    DepartmentSummaryView(id: dept.id)
                                        .environmentObject(deptModel)
                                }

                            }
                            
                            ForEach(deptModel.colleges, id: \.self) { college in
                                
                                CollegeViewCell(college: college)
                                    .environmentObject(settings)
            
                            } // End of ForEach
                        }// End of VStack
                        
                        .padding()
                        .background(Const.Colors.BgGray.color)
                        
                    } // End of Scroll View
                    .padding(.top, 1)

                } // End of VStack
                
            }
            
            
            
        } // End of ZStack

            
    

        
    }
    
}

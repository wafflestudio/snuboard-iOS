//
//  CollegeListView.swift
//  snuboard
//
//  Created by Subeen Park on 2021/06/20.
//

import SwiftUI

struct CollegeListView: View {
    
    @EnvironmentObject var deptModel: DepartmentViewModel
    @EnvironmentObject var settings: Settings
    
    var body: some View {
        
        NavigationView {
            VStack(spacing: 0) {
                
                // TOP BAR
                TopBar("팔로우")
                
                Divider()
        
                ScrollView {
                    VStack(spacing: 10) {
                        
                        ForEach(deptModel.colleges, id: \.self) { college in
                            
                            ForEach(college.departments.filter({!$0.follow.isEmpty}), id: \.self) { dept in
                                DepartmentSummaryView(id: dept.id)
                                    .environmentObject(deptModel)
                                    .environmentObject(settings)
                            }
        
                        } // End of ForEach
                        

                        
                        ForEach(deptModel.colleges, id: \.self) { college in
                            
                            DepartmentListView(college: college)
        
                        } // End of ForEach
                    }// End of VStack
                    .padding()
                    .background(Const.ColorSet.BgGray.color)
                    
                } // End of Scroll View
        
                
            } // End of VStack
            .preferredColorScheme(.light)
        }
        
        
        
            
    }
    
       
}

struct CollegeListView_Previews: PreviewProvider {
    static var previews: some View {
        CollegeListView()
    }
}

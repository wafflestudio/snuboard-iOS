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
    
    var body: some View {
        
        ZStack {
            
            Const.Colors.BgGray.color
            
            VStack(spacing: 0) {
                ScrollView(showsIndicators: false){
                    
                    ForEach(deptModel.colleges, id: \.self) { college in

                        ForEach(college.departments.filter({!$0.follow.isEmpty}), id: \.self) { dept in
                            DepartmentSummaryView(id: dept.id)
                                .environmentObject(deptModel)
                        }

                    }
                    VStack(spacing: 10) {
    
                        ForEach(deptModel.colleges, id: \.self) { college in
                            
                            CollegeViewCell(college: college)
                                .environmentObject(settings)
        
                        } // End of ForEach
                    }// End of VStack
                    .padding(.top, 1)
                } // End of Scroll View
                .padding()
                .background(Const.Colors.BgGray.color)
                
            } // End of VStack
            .padding(.top, settings.showMenu ? 45 : 1 ).animation(.none)
            
        } // End of ZStack
    
            
    

        
    }
    
}

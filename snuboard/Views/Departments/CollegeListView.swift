//
//  CollegeListView.swift
//  snuboard
//
//  Created by Subeen Park on 2021/06/20.
//

import SwiftUI

struct CollegeListView: View {
    
    @EnvironmentObject var deptModel: DepartmentViewModel
    
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            // TOP BAR
            TopBar("팔로우")
            
            Divider()
    
            ScrollView {
                VStack(spacing: 10) {
                    ForEach(deptModel.colleges, id: \.self) { college in
                        
                        DepartmentListView(college: college)
    
                    } // End of ForEach
                }// End of VStack
                .padding()
                .background(Const.ColorSet.BgGray.color)
                
            } // End of Scroll View
            
        }
        
        
        
            
    }
    
       
}

struct CollegeListView_Previews: PreviewProvider {
    static var previews: some View {
        CollegeListView()
    }
}

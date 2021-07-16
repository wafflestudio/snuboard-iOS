//
//  HomeTagListView.swift
//  snuboard
//
//  Created by Subeen Park on 2021/06/26.
//

import SwiftUI

struct HomeTagListView: View {
    
    @EnvironmentObject var settings: Settings
    
    let dept: String
    var deptTags: [String]
    
    init(dept: String, deptTags:[String]) {
        self.dept = dept
        self.deptTags = deptTags
    }
    
    var body: some View {
        FlexibleView(
            data: deptTags,
            spacing: 8,
                alignment: .leading
              )  { item in
            
            HomeTagChipView(dept: dept, item: item).environmentObject(settings)            
                
          }
    }
}

//struct HomeTagListView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeTagListView()
//    }
//}

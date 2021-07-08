//
//  NoticeTags.swift
//  snuboard
//
//  Created by Subeen Park on 2021/07/09.
//

import SwiftUI

struct NoticeTagListView: View {
    
    @EnvironmentObject var deptModel: DepartmentViewModel
    
    let dept: String
    let tags: [String]
    var data: [String] {
        [dept] + tags
    }


    init (dept: String, tags: [String]) {

        self.dept = dept
        self.tags = tags

    }
    
    
    var body: some View {
        
        FlexibleView(
            data: self.data,
            spacing: 8,
                alignment: .leading
              )  { item in
            
            TagChipView(item: item, isDept: dept == item)
            
        }
            
            
        
        
 
    }// end of body
}

//struct NoticeTags_Previews: PreviewProvider {
//    static var previews: some View {
////        NoticeTags()
//    }
//}

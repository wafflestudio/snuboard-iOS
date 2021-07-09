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
    var allTags: [String]
    var selectedTags: [String]
    
    init(dept: String, allTags:[String], selectedTags: [String]) {
        self.dept = dept
        self.allTags = allTags
        self.selectedTags = selectedTags
    }
    
    var body: some View {
        FlexibleView(
            data: allTags,
            spacing: 8,
                alignment: .leading
              )  { item in

            TagChipView(item: item, selected: selectedTags.contains(item), actionIfSelected: {
                    settings.queryParameters[dept]?.append(item)
                }, actionIfUnselected: {
                    settings.queryParameters[dept] = settings.queryParameters[dept]!.filter {$0 != item}
                })
            
                
          }
    }
}

//struct HomeTagListView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeTagListView()
//    }
//}

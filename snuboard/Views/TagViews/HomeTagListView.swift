//
//  HomeTagListView.swift
//  snuboard
//
//  Created by Subeen Park on 2021/06/26.
//

import SwiftUI

struct HomeTagListView: View {
    
    @EnvironmentObject var settings: Settings
    
    var dept: String
    var tags: [String]
    
    init(dept: String, tags: [String]) {
        self.dept = dept
        self.tags = tags
    }
    
    var body: some View {
        FlexibleView(
            data: tags,
            spacing: 8,
                alignment: .leading
              )  { item in
            Group {
                TagChipView(item: item, selected: settings.queryParameters[dept]!.contains(item), actionIfSelected: {
                    settings.queryParameters[dept]?.append(item)
                }, actionIfUnselected: {
                    settings.queryParameters[dept] = settings.queryParameters[dept]!.filter {$0 != item}
                })
            }
            
                
          }
    }
}

//struct HomeTagListView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeTagListView()
//    }
//}

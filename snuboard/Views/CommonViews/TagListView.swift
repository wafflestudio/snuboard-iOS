//
//  TagListView.swift
//  snuboard
//
//  Created by Subeen Park on 2021/06/25.
//

import SwiftUI

struct TagListView: View {
    
    var tagList: [String]
    var followList: [String]
    
    init (tagList: [String], followList: [String]) {
        self.tagList = tagList
        self.followList = followList
    }
    
    
    var body: some View {
        FlexibleView(
            data: tagList,
            spacing: 8,
                alignment: .leading
              )  { item in
            Text(verbatim: item)
                .font(.system(size: 10))
                .foregroundColor(.white)
                .bold()
                .padding(5)
                .padding(.leading, 4)
                .padding(.trailing, 4)
                .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(followList.contains(item) ? Const.ColorSet.MainBlue.color : Const.ColorSet.Unselected.color)
                )
                
          }
          
    }
}

struct TagListView_Previews: PreviewProvider {
    static var previews: some View {
        TagListView(tagList: [
            "Here’s", "to", "the", "crazy", "ones", "the", "misfits", "the", "rebels", "the", "troublemakers", "the", "round", "pegs", "in", "the", "square", "holes", "the", "ones", "who", "see", "things", "differently", "they’re", "not", "fond", "of", "rules"
          ], followList: [
            "Here’s", "to", "the", "crazy", "ones", "the", "misfits", "the", "rebels", "the", "troublemakers", "the", "round", "pegs", "in", "the", "square", "holes", "the", "ones", "who", "see", "things", "differently"
          ])
    }
}

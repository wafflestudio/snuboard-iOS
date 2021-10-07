//
//  HomeTagChipView.swift
//  snuboard
//
//  Created by Subeen Park on 2021/09/10.
//

import SwiftUI


import SwiftUI

struct HomeTagChipView: View {
    
    
    @EnvironmentObject var settings: Settings
    @EnvironmentObject var noticeModel: NoticeViewModel
    
    let item: String
    let id:Int
    let dept: String
    let action: ()->()
    
    var selected: Bool {
        if let selectedTags = settings.queryParameters[dept] {
            return selectedTags.contains(item)
        }
        return false
    }
    
    
    init (id: Int, dept: String, item: String, action: @escaping ()->()) {
        self.dept = dept
        self.item = item
        self.id = id
        self.action = action
    }
 
    var body: some View {

        Text(verbatim: item)
            .font(.system(size: 11))
            .foregroundColor(.white)
            .bold()
            .padding(5)
            .padding(.leading, 4)
            .padding(.trailing, 4)
            .background(
                RoundedRectangle(cornerRadius: 8)
                .fill(selected ? Const.Colors.MainBlue.color : Const.Colors.Unselected.color)
            )
            .onTapGesture {
                
                if selected {
                    if let selectedTags = settings.queryParameters[dept] {
                        settings.queryParameters[dept] = selectedTags.filter({$0 != item})
                    }
                }
                else {
                    settings.queryParameters[dept]?.append(item)
                }
                action()
            }
        
    }
}


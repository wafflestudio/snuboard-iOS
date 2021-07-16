//
//  HomeTagChipView.swift
//  snuboard
//
//  Created by Subeen Park on 2021/07/17.
//


import SwiftUI

struct HomeTagChipView: View {
    
    
    @EnvironmentObject var settings: Settings
    
    let item: String
    let dept: String
    
    var selected: Bool {
        if let selectedTags = settings.queryParameters[dept] {
            return selectedTags.contains(item)
        }
        return false
    }
    
    
    init (dept: String, item: String) {
        self.dept = dept
        self.item = item
    }
 
    var body: some View {

        Text(verbatim: item)
            .font(.system(size: 10))
            .foregroundColor(.white)
            .bold()
            .padding(5)
            .padding(.leading, 4)
            .padding(.trailing, 4)
            .background(
                RoundedRectangle(cornerRadius: 8)
                .fill(selected ? Const.ColorSet.MainBlue.color : Const.ColorSet.Unselected.color)
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
            }
        
    }
}


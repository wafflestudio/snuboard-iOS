//
//  TagChip.swift
//  snuboard
//
//  Created by Subeen Park on 2021/06/26.
//

import SwiftUI

struct TagChipView: View {
    
    
    let item: String
    var activateTagSelect = true
    var isDept = false
    @State var selected = false

    var actionIfSelected: () -> Void = {}
    var actionIfUnSelected: () -> Void = {}
    
    init (item: String, isDept: Bool) {
        self.item = item
        self.isDept = isDept
    }

    
    
    init (item: String, selected: Bool, actionIfSelected: @escaping ()-> Void, actionIfUnselected: @escaping ()->Void) {
        self.item = item
        self.selected = selected
        self.actionIfSelected = actionIfSelected
        self.actionIfUnSelected = actionIfUnselected
    }
    
    init (item: String, activateTagSelect: Bool, selected: Bool, actionIfSelected: @escaping ()-> Void, actionIfUnselected: @escaping ()->Void) {
        self.item = item
        self.activateTagSelect = false
        self.selected = selected
        self.actionIfSelected = actionIfSelected
        self.actionIfUnSelected = actionIfUnselected
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
                    .fill(isDept ? Color(UserDefaults.standard.deptColor[item]!) : selected ? Const.ColorSet.MainBlue.color : Const.ColorSet.Unselected.color)
            )
            .onTapGesture {
                if activateTagSelect {
                    selected.toggle()
                    if selected {
                        actionIfSelected()
                    }
                    else {
                        actionIfUnSelected()
                    }
                }
            }
        
    }
}

struct TagChipView_Previews: PreviewProvider {
    static var previews: some View {
        TagChipView(item: "입학", selected: false, actionIfSelected: {
            print("action")
        }, actionIfUnselected: {
            
        })
    }
}

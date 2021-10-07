//
//  TagViewCell.swift
//  snuboard
//
//  Created by Subeen Park on 2021/09/10.
//

import SwiftUI

enum TagType {
    case follow
    case search
    case department
}

struct TagViewCell: View {
    
    let item: String
    let cellType: TagType
    let actionIfSelected: (()->Void)?
    let actionIfUnselected: (()->Void)?
    let deptColor: String?
    @State var isSelected = false
    var chipColor: String {
        if let color = deptColor {
            return color
        } else {
            return isSelected ? Const.Colors.MainBlue.rawValue : Const.Colors.Unselected.rawValue
        }
    }
    
    // department type
    init(item: String, type: TagType, deptColor: String? = nil) {
        self.item = item
        self.cellType = type
        self.actionIfSelected = nil
        self.actionIfUnselected = nil
        self.deptColor = deptColor
    }
    
    // follow, search
    init(item: String, type: TagType, actionIfSelected: (()->Void)?, actionIfUnselected: (()->Void)?) {
        self.item = item
        self.cellType = type
        self.actionIfSelected = actionIfSelected
        self.actionIfUnselected = actionIfUnselected
        self.deptColor = nil
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
                .fill(Color(chipColor))
            )
            .onTapGesture {
                switch self.cellType {
                case .follow, .search:
                    isSelected.toggle()
                    if isSelected {
                        if let action = actionIfSelected {
                            action()
                        } else { return }
                    } else {
                        if let action = actionIfUnselected {
                            action()
                        } else { return }
                    }
                case .department:
                    break
                } // end of switch
            } // end of tap gesture
    } // end of body

} // end of view

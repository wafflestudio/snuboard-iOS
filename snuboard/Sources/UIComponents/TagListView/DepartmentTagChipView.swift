//
//  DepartmentTagChipView.swift
//  snuboard
//
//  Created by Subeen Park on 2021/09/10.
//

import SwiftUI

struct DepartmentTagChipView: View {
    
    let item: String
    let isDept: Bool
    
    
    init (item: String, isDept: Bool) {
        self.item = item
        self.isDept = isDept
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
                    .fill(isDept ? Color(UserDefaults.standard.deptColor[item] ?? Const.Colors.color_palette[2] ) : Const.Colors.Unselected.color)
            )
        
    }
}


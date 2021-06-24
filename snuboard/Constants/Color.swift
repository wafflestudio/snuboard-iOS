//
//  Colors.swift
//  snuboard
//
//  Created by Subeen Park on 2021/06/14.
//

import SwiftUI


extension Const {
    enum ColorSet: String {
        case Gray1 = "Gray1"
        case Gray2 = "Gray2"
        case Gray3 = "Gray3"
        case Gray4 = "Gray4"
        case Gray5 = "Gray5"
        case Gray6 = "Gray6"
        case MainBlue = "MainBlue"
        case BgGray = "BgGray"
        case Unselected = "Unselected"
        
        var color: Color {
            return Color(self.rawValue)
        }
        
    }
}

//
//  Colors.swift
//  snuboard
//
//  Created by Subeen Park on 2021/08/30.
//

import SwiftUI

extension Const {
    
    enum Colors: String {
        
        case Gray1 = "Gray1"
        case Gray2 = "Gray2"
        case Gray3 = "Gray3"
        case Gray4 = "Gray4"
        case Gray5 = "Gray5"
        case Gray6 = "Gray6"
        case MenuGray = "MenuGray"
        case MainBlue = "MainBlue"
        case Blue2 = "Blue2"
        case BgGray = "BgGray"
        case Unselected = "Unselected"
        
        var color: Color {
            return Color(self.rawValue)
        }
        
        static let color_palette = ["석류", "감귤", "들국", "완두", "비취", "지중해", "하늘", "라벤더", "자수정"]
        
    }
}

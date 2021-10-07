//
//  ColorPalette.swift
//  snuboard
//
//  Created by Subeen Park on 2021/09/10.
//


import SwiftUI

struct PaletteCell: View {
    
    var color: String
    var dept: String
    @EnvironmentObject var settings: Settings
    
    init (color: String, dept: String) {
        self.color = color
        self.dept = dept
    }
    
    
    var body: some View {
        HStack {
            Circle()
                .foregroundColor(Color(color))
                .frame(width: 14, height: 14, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            Text(color)
                .font(.system(size: 11))
            Spacer()
            if color == settings.deptColor[dept] {
                Image("check").resizable().frame(width: 13, height: 13, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }
        }
        
        
    }
    
}

struct ColorPalette: View {
    
    var dept: String
    
    @State var colorSelected: String
    @EnvironmentObject var settings: Settings
    
    init(dept: String) {
        self.dept = dept
        colorSelected = UserDefaults.standard.deptColor[dept] ?? Const.Colors.color_palette[1]
    }
        

    let color_set = [["석류", "완두", "하늘"], ["감귤", "비취", "라벤더"], ["들국", "지중해", "자수정"]]
    
    var body: some View {
        HStack(spacing: 20) {
            ForEach(color_set, id: \.self) { row in
                VStack {
                    ForEach(row, id: \.self) { color in
                        PaletteCell(color: color, dept: dept)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                self.settings.deptColor[dept] = color
                            }
                    }
                }
                
            }
        } // End of HStack
        .onAppear {
            settings.deptColor = UserDefaults.standard.deptColor
        }
        
    }
}




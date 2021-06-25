//
//  ColorPallete.swift
//  snuboard
//
//  Created by Subeen Park on 2021/06/25.
//

import SwiftUI

struct PaletteCell: View {
    
    var color: String
    
    init (color: String) {
        self.color = color
    }
    
    var body: some View {
        HStack {
            Circle()
                .foregroundColor(Color(color))
                .frame(width: 14, height: 14, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            Text(color)
                .font(.system(size: 10))
            Spacer()
        }
        
        
    }
    
}

struct ColorPalette: View {
    
    let color_set = [["석류", "감귤", "들국"], ["완두", "비취", "지중해"], ["하늘", "라벤더", "자수정"]]
    
    var body: some View {
        VStack {
            ForEach(color_set, id: \.self) { row in
                HStack {
                    ForEach(row, id: \.self) { color in
                        PaletteCell(color: color)
                    }
                }
                
            }
        }
        
    }
}

struct ColorPalette_Previews: PreviewProvider {
    static var previews: some View {
        ColorPalette()
    }
}

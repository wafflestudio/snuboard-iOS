//
//  ImageModifiers.swift
//  snuboard
//
//  Created by Subeen Park on 2021/08/31.
//

import SwiftUI

// imageResizer
extension Image {
    func resizeImage(width: CGFloat, height: CGFloat) -> some View {
        self
            .resizable()
            .scaledToFit()
            .frame(width: width, height: height, alignment: .center)
        
    }
}



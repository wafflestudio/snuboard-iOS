//
//  PlaceHolderView.swift
//  snuboard
//
//  Created by Subeen Park on 2021/09/14.
//

import SwiftUI

struct PlaceHolderView: View {
    
    let imageStr: String
    
    init(_ imageStr: String) {
        self.imageStr = imageStr
    }
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Image(self.imageStr)
                    .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
            }
            Spacer()
        }
    }
}

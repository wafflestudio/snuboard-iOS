//
//  LogoTopBar.swift
//  snuboard
//
//  Created by Subeen Park on 2021/07/09.
//

import SwiftUI

struct LogoTopBar: View {
    var body: some View {
        ZStack {
            HStack {
                Spacer()
                Image("logo_horizontal")
                    .frame(height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                Spacer()
            }
            HStack {
                Image("menu")
                Spacer()
                Image("search")
            }.padding([.leading, .trailing], 12)
        }.padding(.bottom, 10)
        
        
    }
}

struct LogoTopBar_Previews: PreviewProvider {
    static var previews: some View {
        LogoTopBar()
    }
}

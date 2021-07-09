//
//  TopBar.swift
//  snuboard
//
//  Created by Subeen Park on 2021/06/24.
//

import SwiftUI

struct TopBar: View {
    
    let title: String
    
    init(_ title: String) {
        self.title = title
    }
    
    var body: some View {
        VStack {
            ZStack {
                HStack {
                    Spacer()
                    Text(title)
                        .bold()
                        .font(.system(size: 20))
                    Spacer()
                }
                HStack {
                    Image("menu")
                        .frame(width: 26, height: 26, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .padding(.leading, 12)
                    Spacer()
                }
            } // End of TOP Bar ZStack
        }.frame(height: 44, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        
    }
    
}

struct TopBar_Previews: PreviewProvider {
    static var previews: some View {
        TopBar("팔로우")
    }
}

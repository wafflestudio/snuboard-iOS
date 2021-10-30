//
//  Collapsible.swift
//  snuboard
//
//  Created by Subeen Park on 2021/10/28.
//
// Reference: https://betterprogramming.pub/how-to-write-a-collapsible-expandable-view-for-your-swiftui-app-d4a47fe8cb52

import SwiftUI

struct Collapsible<Content: View>: View {
    @State var label: () -> Text
    @State var content: () -> Content

    @State private var collapsed: Bool = true
    
    var body: some View {
        VStack {
            Button(
                action: { self.collapsed.toggle() },
                label: {
                    HStack {
                        Image("domain")
                            .resizable()
                            .frame(width: 20, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        self.label()
                            .bold()
                            .font(.system(size: 17))
                            .foregroundColor(Const.Colors.Gray2.color)
                        Spacer()
                        Image(systemName: self.collapsed ? "chevron.down" : "chevron.up")
                    }
                    .contentShape(Rectangle())
                    .padding(8)
                    .background(Color.clear)
                    
                }
            )
            .buttonStyle(PlainButtonStyle())
            
            VStack(spacing: 12) {
                self.content()
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: collapsed ? 0 : .none)
            .clipped()
//            .animation(.easeOut)
            .transition(.slide)
            .padding(.leading, 13)
            .padding([.top, .bottom], self.collapsed ? 0 : 6)
            .background(Color.clear)
            
        }
        .padding([.leading, .trailing, .top], 5)
        .background(RoundedRectangle(cornerRadius: 8).fill(.white))
    
    }
}

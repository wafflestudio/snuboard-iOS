//
//  NavigationDrawer.swift
//  snuboard
//
//  Created by Subeen Park on 2021/09/03.
// reference: https://www.iosapptemplates.com/blog/swiftui/navigation-drawer-swiftui

import SwiftUI

struct NavigationDrawer: View {
    
    @EnvironmentObject var envModel: EnvModel

    private let width = UIScreen.main.bounds.width - 100
    let isOpen: Bool
    
    var body: some View {
        HStack {
            DrawerContent().environmentObject(envModel)
                .frame(width: self.width)
                .offset(x: self.isOpen ? 0 : -self.width)
                .animation(.default)
            Spacer()
        }
    }
}

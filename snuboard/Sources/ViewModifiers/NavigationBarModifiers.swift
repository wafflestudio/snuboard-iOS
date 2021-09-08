//
//  NavigationBarModifiers.swift
//  snuboard
//
//  Created by Subeen Park on 2021/09/03.
//

import SwiftUI

extension View {
    
    func hideNavigationBar() -> some View {
        self
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
    }
    
    func applyCustomBackButton(action: @escaping ()->()) -> some View {
        self
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action: {
            action()
        }, label: {
            Image("navigateBefore")
        }))
            .navigationBarTitle("", displayMode: .inline)
            .navigationViewStyle(StackNavigationViewStyle())
    }

}

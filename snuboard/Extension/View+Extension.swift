//
//  View+Extension.swift
//  snuboard
//
//  Created by Subeen Park on 2021/06/24.
//

import SwiftUI
import UIKit


// Navigation var related extensions
extension View {
    
    
    func hideNavigationBar() -> some View {
        self
            .preferredColorScheme(.light)
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
    }
    
    static func whiteNavigationBar() {
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
//        UINavigationBar.appearance().shadowImage = UIImage()
    }
    
    
    func customNavBarWithOutSearch(title: String, action: @escaping ()->()) -> some View {
        
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont.systemFont(ofSize: 20, weight: .bold)]
        UINavigationBar.appearance().backgroundColor = .white

        return self
            .navigationBarTitle(title)
            .background(Color.white)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading:
                                    Image("navigate_before")
                                    .renderingMode(/*@START_MENU_TOKEN@*/.template/*@END_MENU_TOKEN@*/)
                                    .foregroundColor(.black)
                                    .onTapGesture {
                                        action()
                                    })
    }

    
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

extension View {
  func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
    background(
      GeometryReader { geometryProxy in
        Color.clear
          .preference(key: SizePreferenceKey.self, value: geometryProxy.size)
      }
    )
    .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
  }
}

private struct SizePreferenceKey: PreferenceKey {
  static var defaultValue: CGSize = .zero
  static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}


extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}



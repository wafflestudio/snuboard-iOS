//
//  ButtonModifiers.swift
//  snuboard
//
//  Created by Subeen Park on 2021/08/30.
//

import SwiftUI

// BLUE BUTTON MODIFIERS
// Text: white, bold, 12pt
// Background: Main blue
// Border radius : 8px

// USAGE
// Text("blahblah").blueButtonText()
// Button().blueButtonBackground()

struct blueButtonTextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            // font settings
            .foregroundColor(.white)
            .font(.system(size: 12))
    }
}

extension Text {
    func blueButtonText() -> some View {
        self
            .bold()
            .modifier(blueButtonTextModifier())
    }
}


struct blueButtonBackgroundModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(RoundedRectangle(cornerRadius: 8)
            .foregroundColor(Const.Colors.MainBlue.color))
    }
}

extension View {
    func blueButtonBackground() -> some View {
        self
            .modifier(blueButtonBackgroundModifier())
    }
}



// White BUTTON MODIFIERS
// Text: Gray1, bold, 12pt
// Background: White
// Border radius : 8px
// Border: 1px solid gray1

// USAGE
// Text("blahblah").blueButtonText()
// Button().blueButtonBackground()

struct blackBorderButtonTextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            // font settings
            .foregroundColor(Const.Colors.Gray1.color)
            .font(.system(size: 12))
    }
}

extension Text {
    func blackBorderButtonText() -> some View {
        self
            .bold()
            .modifier(blackBorderButtonTextModifier())
    }
}


struct blackBorderButtonBackgroundModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Const.Colors.Gray1.color, lineWidth: 1)
            )
    }
}

extension View {
    func blackBorderButtonBackground() -> some View {
        self
            .modifier(blackBorderButtonBackgroundModifier())
    }
}

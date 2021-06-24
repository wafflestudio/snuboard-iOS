//
//  ClearButton.swift
//  snuboard
//
//  Created by Subeen Park on 2021/06/21.
//

import SwiftUI


struct ClearButton: ViewModifier {
    @Binding var text: String
    @Binding var show: Bool
   
    public func body(content: Content) -> some View {
        
            HStack {
                content
                if show {
                    Button(action: {
                        self.text = ""
                    }) {
                        Image(systemName: "multiply.circle.fill")
                            .foregroundColor(.secondary)
                    }
                }
            }
        
        
    }
}

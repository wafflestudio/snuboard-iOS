//
//  UIApplication+Extension.swift
//  snuboard
//
//  Created by Subeen Park on 2021/09/18.
//

import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

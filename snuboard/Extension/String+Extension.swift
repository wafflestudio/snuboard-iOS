//
//  String+Extension.swift
//  snuboard
//
//  Created by Subeen Park on 2021/06/25.
//

import Foundation


extension String {
    func substring(from: Int, to: Int) -> String {
        guard from < count, to >= 0, to - from >= 0 else {
            return ""
        }
        
        let startIndex = index(self.startIndex, offsetBy: from)
        let endIndex = index(self.startIndex, offsetBy: to + 1)
        return String(self[startIndex ..< endIndex])
    }
    
    func asDate() -> String {
        return "\(self.substring(from: 2, to: 3))/\(self.substring(from: 5, to: 6))/\(self.substring(from: 8, to: 9))"
    }
}

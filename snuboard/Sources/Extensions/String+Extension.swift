//
//  String+Extension.swift
//  snuboard
//
//  Created by Subeen Park on 2021/09/10.
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


// Reference: https://mattmaddux.github.io/2018/05/14/Converting-Strings-to-Base64-URL/
extension String {
    
    func fromBase64URL() -> String? {
            var base64 = self
            base64 = base64.replacingOccurrences(of: "-", with: "+")
            base64 = base64.replacingOccurrences(of: "_", with: "/")
            while base64.count % 4 != 0 {
                base64 = base64.appending("=")
            }
            guard let data = Data(base64Encoded: base64) else {
                return nil
            }
            return String(data: data, encoding: .utf8)
        }
        
    func toBase64URL() -> String {
        
        print(self.utf8)
        var result = Data(self.utf8).base64EncodedString()
        result = result.replacingOccurrences(of: "+", with: "-")
        result = result.replacingOccurrences(of: "/", with: "_")
        result = result.replacingOccurrences(of: "=", with: "%")
        return result
    }
}

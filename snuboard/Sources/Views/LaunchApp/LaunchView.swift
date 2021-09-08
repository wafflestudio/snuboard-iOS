//
//  LaunchView.swift
//  snuboard
//
//  Created by Subeen Park on 2021/08/31.
//

import SwiftUI

struct LaunchView: View {
    var body: some View {
        NavigationView {
            
            // VStack 0
            VStack(spacing: 120) {
                
                // VStack 1: logo + text
                VStack(spacing: 20) {
                    // square logo
                    Image("squareLogo")
                        .resizeImage(width: 141, height: 141)
                    
                    // text
                    Text("모든 공지사항을 스누보드에서")
                        .foregroundColor(Const.Colors.Gray3.color)
                        .font(.system(size: 17))
                } // End of VStack 1
                
                // Button
                NavigationLink(
                    destination: PolicyAgree(),
                    label: {
                        Text("시작하기")
                            .blueButtonText()
                            .frame(width: 193, height: 40, alignment: .center)
                            .blueButtonBackground()
                    })

            } // End of outer VStack0
            
        } // End of NavigationView
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}

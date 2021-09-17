//
//  SignUpView.swift
//  snuboard
//
//  Created by Subeen Park on 2021/09/15.
//

import SwiftUI

struct SignUpView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    @EnvironmentObject var envModel : EnvModel
    
    var body: some View {
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
            NavigationLink(destination: PolicyAgree().environmentObject(envModel), isActive: $viewModel.pushActive) { EmptyView() }
            
            Text("시작하기")
                .blueButtonText()
                .frame(width: 193, height: 40, alignment: .center)
                .blueButtonBackground()
                .onTapGesture {
                    viewModel.signUp()
                }

        } // End of outer VStack0
    }
}


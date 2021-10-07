//
//  PrivacyPolicy.swift
//  snuboard
//
//  Created by Subeen Park on 2021/09/08.
//

import SwiftUI

import SwiftUI

struct PrivacyPolicy: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var envModel: EnvModel
    
    
    var body: some View {
        
        // VStack 0
        VStack(spacing: 30) {
            
            // Logo
            Image("horizontalLogo")
                .resizeImage(width: 208, height: 52)
            
            // Text
            HTMLView(htmlContent: Const.POLICY)
            
            // Button
            Button(action: {
                    envModel.isDrawerOpen = false
                    envModel.showPrivacy = false
                    presentationMode.wrappedValue.dismiss()
                    }, // end of button action
                   label: {
                    Text("확인")
                        .blueButtonText()
                        .frame(width: 143, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .blueButtonBackground()
                   }) // end of button
            
        } // End of VStack 0
        .hideNavigationBar()
        .padding(.top, 20)
        .padding(.bottom, 60)
        .padding([.leading, .trailing], 20)

    }
    
    
}

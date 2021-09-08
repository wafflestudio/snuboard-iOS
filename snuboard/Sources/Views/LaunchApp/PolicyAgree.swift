//
//  PolicyAgree.swift
//  snuboard
//
//  Created by Subeen Park on 2021/08/31.
//

import SwiftUI

struct PolicyAgree: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var envModel: EnvModel
    @ObservedObject var viewModel = SignUpViewModel()
    @State var isActive = false
    
    init() {
        UINavigationBar.appearance().shadowImage = UIImage()
    }
    
    var body: some View {
        
        // dummy navigation link
        NavigationLink(destination: EmptyView()) {
            EmptyView()
        }
        NavigationLink(destination: HomeTabView().environmentObject(envModel), isActive: $isActive) { EmptyView() }
        
        // VStack 0
        VStack(spacing: 30) {
            
            // Logo
            Image("horizontalLogo")
                .resizeImage(width: 208, height: 52)
            
            // Text
            HTMLView(htmlContent: Const.POLICY)
            
            // Button
            Button(action: {
                    
                    viewModel.signUp(toggleLoading: {
                        self.envModel.toggleLoading()
//                        self.envModel.isDrawerOpen = true
                    }, completion: {
                        self.isActive = true
                    })}, // end of button action
                   label: {
                    Text("동의하기")
                        .blueButtonText()
                        .frame(width: 143, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .blueButtonBackground()
                   }) // end of button
            
        } // End of VStack 0
        .applyCustomBackButton(action: {
            presentationMode.wrappedValue.dismiss()
        })
        .padding(.top, 10)
        .padding(.bottom, 60)
        .padding([.leading, .trailing], 20)
    }
    
}

struct PolicyAgree_Previews: PreviewProvider {
    static var previews: some View {
        PolicyAgree()
    }
}

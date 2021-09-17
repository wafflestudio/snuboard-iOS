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
    @StateObject var deptModel: DepartmentListViewModel = DepartmentListViewModel()
    @StateObject var settings = Settings()
    @State var pushActive = false

    
    var body: some View {
        
        // VStack 0
        VStack(spacing: 30) {
            
            // Logo
            Image("horizontalLogo")
                .resizeImage(width: 208, height: 52)
            
            // Text
            HTMLView(htmlContent: Const.POLICY)
            
            // Button
            NavigationLink(destination: HomeTabView()
                            .environmentObject(envModel)
                            .environmentObject(deptModel)
                            .environmentObject(settings)
                            .navigationBarBackButtonHidden(true),
                           isActive: $pushActive, label: {
                Button(action: {
                    self.pushActive = true
                }, label: {
                    Text("동의하기")
                        .blueButtonText()
                        .frame(width: 143, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .blueButtonBackground()
                })
            })
            
            
        } // End of VStack 0
        .applyCustomBackButton(action: {
            presentationMode.wrappedValue.dismiss()
        })
        .onAppear {
            print("policy Agree")
        }
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

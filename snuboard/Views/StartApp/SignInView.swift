//
//  SignInView.swift
//  snuboard
//
//  Created by Subeen Park on 2021/06/14.
//

import SwiftUI

struct SignInView: View {
    
    @ObservedObject var viewModel = SignInViewModel()

    var body: some View {
        
        VStack(spacing: 20)
        {
            UnderlinedTextFieldView(label: "Username", placeholder: "", field: $viewModel.username)
            UnderlinedTextFieldView(label: "Password", placeholder: "", secureMode: true, field: $viewModel.password)
            
            Spacer()
            
            NavigationLink(destination: MainTabView().colorScheme(.light), isActive: $viewModel.pushActive) { EmptyView() }
            
            Button(action: {
                viewModel.signIn()
            }, label: {
                Text("로그인")
                    .bold()
                    .foregroundColor(.white)
                    .font(.system(size: 12))
            })
            .frame(width: 193, height: 40, alignment: .center)
            .background(RoundedRectangle(cornerRadius: 8).foregroundColor(Const.ColorSet.MainBlue.color))
                
        } // end of Vstack
        .frame(width: UIScreen.main.bounds.size.width - 60, height: UIScreen.main.bounds.size.height / 2 , alignment: .center)
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .ignoresSafeArea(.keyboard)
        .contentShape(Rectangle())
        .onTapGesture {
            hideKeyboard()
        }
        

    }
        
            
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}

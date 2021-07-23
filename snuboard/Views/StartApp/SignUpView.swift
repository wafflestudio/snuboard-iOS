//
//  SignUpView.swift
//  snuboard
//
//  Created by Subeen Park on 2021/06/14.
//

import SwiftUI


struct SignUpView: View {
    
    @ObservedObject var viewModel = SignUpViewModel()
    
    
    var body: some View {

        NavigationView {
        
            VStack(spacing: 20)
            {
                UnderlinedTextFieldView(label: "Username", placeholder: "", field: $viewModel.username)
                
                UnderlinedTextFieldView(label: "E-mail", placeholder: "",  field: $viewModel.email)
                
                UnderlinedTextFieldView(label: "Password", placeholder: "", secureMode: true, field: $viewModel.password)
                
                UnderlinedTextFieldView(label: "Confirm Password", placeholder: "", secureMode: true, field: $viewModel.confirmPassword)
                
                
                    
                Spacer()
                
                // SIGNUP BUTTON
                
                
                NavigationLink(destination: MainTabView().colorScheme(.light), isActive: $viewModel.pushActive) { EmptyView() }
                
                
                Button(action: {
                        viewModel.signUp()
                    }, label: {
                        Text("다음으로").foregroundColor(Const.ColorSet.Gray1.color)
                            .bold()
                            .font(.system(size: 12))
                    })
                    .frame(width: 193, height: 40, alignment: .center)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Const.ColorSet.Gray1.color, lineWidth: 1)
                    )
                    
                    
            } // End of vstack
            .frame(width: UIScreen.main.bounds.size.width - 60, height: UIScreen.main.bounds.size.height / 2 , alignment: .center)
        
        } // End of Navigation view
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .ignoresSafeArea(.keyboard)
        .onTapGesture {
            hideKeyboard()
        }
        
        
    }
    
    
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}

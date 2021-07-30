//
//  StartAppView.swift
//  snuboard
//
//  Created by Subeen Park on 2021/06/14.
//

import SwiftUI

struct StartAppView: View {
    
    @State private var showingSignInSheet = false
    @State private var showingSignUpSheet = false
    @State private var action: Int? = 0
    @ObservedObject var viewModel = SignInViewModel()
    
    var body: some View {
        
        
        

        ZStack {
            Color.white.ignoresSafeArea()
            NavigationView {
                
                VStack {
                    
                    NavigationLink(destination: MainTabView().colorScheme(.light), isActive: $viewModel.pushActive) { EmptyView() }
                    
                    NavigationLink(destination: SignUpView().colorScheme(.light), tag: 1, selection: $action) {
                        EmptyView()
                    }
                    
                    NavigationLink(destination: SignInView().colorScheme(.light), tag: 2, selection: $action) {
                        EmptyView()
                    }
                    
                                    
                    
                    // LOGO AND DESCRIPTION
                    Image("AppLogo")
                    Text("스누보드에서 서울대학교의 모든 공지사항을 모아보세요")
                        .foregroundColor(Const.ColorSet.Gray3.color)
                        .font(.system(size: 10))
                    
                    Spacer()
                    
                    // TERMS AND CONDITIONS
                    Group {
                        Text("계정이 왜 필요한가요?")
                            .foregroundColor(Const.ColorSet.Gray3.color)
                            .font(.system(size: 12))
                            .underline()
                        
                        Spacer().frame(height: 4)
                        
                        Text("서비스 이용약관 및 개인정보 처리 방침")
                            .foregroundColor(Const.ColorSet.Gray3.color)
                            .font(.system(size: 12))
                            .underline()
                    }.lineSpacing(14)
                    
                    
                    
                    Spacer().frame(height:20)
                    
                    // BUTTONS
                    VStack {
                        
                        // SIGNUP BUTTON

                        Button(action: {
                            self.action = 1
                        }, label: {
                            Text("회원가입").foregroundColor(Const.ColorSet.Gray1.color)
                                .bold()
                                .font(.system(size: 12))
                            
                        })
                        .frame(width: 193, height: 40, alignment: .center)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Const.ColorSet.Gray1.color, lineWidth: 1)
                        )

                        
                        Spacer()
                        
                        // SIGNIN BUTTON
                        Button(action: {
                            self.action = 2
                        }, label: {
                            Text("로그인")
                                .bold()
                                .foregroundColor(.white)
                                .font(.system(size: 12))
                        })
                        .frame(width: 193, height: 40, alignment: .center)
                        .background(RoundedRectangle(cornerRadius: 8).foregroundColor(Const.ColorSet.MainBlue.color))
                            
                        
                        
                        
                    } // END OF BUTTONS VSTACK
                    .frame(width: 193, height: 90, alignment: .center)

                    
                    
                }
                .frame(width: 252, height: 452, alignment: .center)
                
            }
        }.onAppear {
            if let id = TokenUtils.loadID(), let pw = TokenUtils.loadPW() {
                viewModel.autoLogin(username: id, password: pw)
            }
        }


        
    }
}

struct StartAppView_Previews: PreviewProvider {
    static var previews: some View {
        StartAppView()
            .preferredColorScheme(.dark)
    }
}

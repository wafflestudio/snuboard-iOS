//
//  VersionInfo.swift
//  snuboard
//
//  Created by Subeen Park on 2021/09/03.
//

import SwiftUI


struct VersionInfo: View {
    
    @Environment(\.presentationMode) var presentationMode
    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    @EnvironmentObject var envModel: EnvModel
    
    var body: some View {
        
        VStack {
            
            Spacer()
            HStack {
                Spacer()
                Image("squareLogo").resizable().frame(width: 167, height: 167, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                Spacer()
            }
            Text("버전 \(appVersion ?? "0.0.1")")
                .font(.system(size: 20))
                .foregroundColor(Const.Colors.Gray3.color)
            Text("최신 업데이트 2021.08.20")
                .font(.system(size: 20))
                .foregroundColor(Const.Colors.Gray3.color)
            Spacer()
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .padding(10)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Image("navigateBefore").onTapGesture {
                    envModel.isDrawerOpen = true
                    envModel.showVersinoInfo = false
                    presentationMode.wrappedValue.dismiss()
                }
            }
            ToolbarItem(placement: .principal) {
                Text("버전 정보")
                    .bold()
                    .font(.system(size: 20))
            }
        }
        .frame(width: UIScreen.main.bounds.width)
    }

}


//
//  DeveloperInfoView.swift
//  snuboard
//
//  Created by Subeen Park on 2021/09/08.
//

import SwiftUI

struct DeveloperInfoView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var envModel: EnvModel
    
    var body: some View {
        
        VStack(alignment: .leading) {
            ForEach(DeveloperData.snuboardDevelopers, id: \.self) { developer in
                DeveloperInfoViewCell(developer: developer)
            }
            Spacer()
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .padding(10)
        .background(Const.Colors.BgGray.color)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Image("navigateBefore").onTapGesture {
                    envModel.isDrawerOpen = true
                    envModel.showTeamSnuboard = false
                    presentationMode.wrappedValue.dismiss()
                }
            }
            ToolbarItem(placement: .principal) {
                Text("팀 스누보드")
                    .bold()
                    .font(.system(size: 20))
            }
        }

        
        
    }
}



struct DeveloperInfoViewCell: View {
    
    var developer: Developer
    
    init(developer: Developer) {
        self.developer = developer
    }
    
    var body: some View {
        
        VStack(spacing: 5) {
            
            HStack(spacing: 5) {
                Text(developer.position)
                    .font(.system(size: 10))
                    .foregroundColor(.white)
                    .bold()
                    .padding([.leading, .trailing], 9)
                    .padding([.top, .bottom], 5)
                    .background(RoundedRectangle(cornerRadius: 8).fill(Color(developer.color)))
                ForEach(developer.tags, id: \.self) { tag in
                    Text(tag)
                        .font(.system(size: 10))
                        .foregroundColor(.white)
                        .bold()
                        .padding([.leading, .trailing], 9)
                        .padding([.top, .bottom], 5)
                        .background(RoundedRectangle(cornerRadius: 8).fill(Const.Colors.Unselected.color))
                }
                Spacer()
            }
            
            HStack {
                Text(developer.name)
                    .font(.system(size: 16))
                    .bold()
                    .foregroundColor(Const.Colors.Gray2.color)
                Spacer()
                
                if let blog = developer.blog {
                    Link(destination: URL(string: blog)!, label: {
                        Image("blog")
                            .resizable()
                            .frame(width: 24, height: 24, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    })
                }
                
                if let mailURL = URL(string: "googlegmail:///co?to=\(developer.email)") {
                    Link(destination: mailURL, label: {
                        Image("at")
                            .resizable()
                            .frame(width: 24, height: 24, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    })
                    
                }

                
                
                Link(destination: URL(string: developer.gitHub)!, label: {
                    Image("github")
                        .resizable()
                        .frame(width: 24, height: 24, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                })
            }
        }
        .padding(12)
        .background(RoundedRectangle(cornerRadius: 8).fill(Color.white))
            

    }
}



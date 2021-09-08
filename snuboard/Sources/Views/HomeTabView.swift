//
//  HomeTabView.swift
//  snuboard
//
//  Created by Subeen Park on 2021/09/03.
//
//
import SwiftUI

struct HomeTabView: View {
    
    @EnvironmentObject var envModel: EnvModel
    @State private var selection = 0
    
    
    var body: some View {
            
        TabView(selection: $selection) {
            
            // TAB 1
            FeedView()
                .tabItem {
                    selection == 0 ? Image("dynamic_feed_active").renderingMode(.template) : Image("dynamic_feed").renderingMode(.template)
                    Text("피드")
                        .font(.system(size: 12))
                }.onTapGesture {
                    selection = 0
                }.tag(0)
            
            // TAB 2
            Text("View2")
                .tabItem {
                    selection == 1 ? Image("domain_active").renderingMode(.template) : Image("domain").renderingMode(.template)
                    Text("학과")
                        .font(.system(size: 12))
                }.onTapGesture {
                    selection = 1
                }.tag(1)
            
            // TAB 3
            Text("View3")
                .tabItem {
                    selection == 2 ? Image("favorite_selected").resizable().frame(width: 32, height: 32, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).scaledToFit() : Image("favorite_unselected").resizable().frame(width: 32, height: 32, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).scaledToFit()

                    Text("관심목록")
                        .font(.system(size: 12))
                }.onTapGesture {
                    selection = 2
                }.tag(2)
        } // End of tab view
        .zIndex(0)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal, content: {
                Image("horizontalLogo")
            })
            ToolbarItem(placement: .navigationBarLeading, content: {
                Button(action: {
                    envModel.isDrawerOpen = true
                }) {
                    Image("menu")
                        .resizable()
                        .frame(width: 24, height: 24, alignment: .center)

                }
            })
        } // end of toolbar
            

    } // End of Body 
}

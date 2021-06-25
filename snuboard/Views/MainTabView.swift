//
//  TabView.swift
//  snuboard
//
//  Created by Subeen Park on 2021/06/24.
//

import SwiftUI

struct MainTabView: View {
    
    @StateObject var deptModel = DepartmentViewModel()
    
    init() {
        UITabBar.appearance().barTintColor = .white
        UITabBar.appearance().tintColor = UIColor(named: "Main Blue")
    }
    
    var body: some View {

        TabView() {
            
            ZStack {
                Color.red.hideNavigationBar()
                TagChipView(item: "tagChip", selected: false, actionIfSelected: {print("selected")}, actionIfUnselected: {
                    print("unselected")
                })
            }
                .tabItem {
                    Image("dynamic_feed").renderingMode(.template)
                    Text("피드")
                        .font(.system(size: 12))
                }
            
            
            CollegeListView().hideNavigationBar()
                .tabItem {
                    Image("domain").renderingMode(.template)
                    Text("학과")
                        .font(.system(size: 12))
                }
            Text("Tab3").hideNavigationBar()
                .tabItem {
                    Image("favorite_border").renderingMode(.template)
                    Text("관심목록")
                        .font(.system(size: 12))
                }
            
        } // End of tab view
        .hideNavigationBar()
        .environmentObject(deptModel)
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}

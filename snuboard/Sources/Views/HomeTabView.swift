//
//  HomeTabView.swift
//  snuboard
//
//  Created by Subeen Park on 2021/09/03.
//
//
import SwiftUI

struct HomeTabView: View {
    
    @StateObject var deptModel: DepartmentListViewModel = DepartmentListViewModel()
    @StateObject var settings: Settings = Settings()
    @EnvironmentObject var envModel: EnvModel
    @State private var selection = 0

    
    
    var body: some View {
            
        TabView(selection: $selection) {
            
            // TAB 1
            FeedView()
                .tabItem {
                    selection == 0 ? Image("dynamic_feed_active").resizable().frame(width: 32, height: 32, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).scaledToFit() : Image("dynamic_feed").resizable().frame(width: 32, height: 32, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).scaledToFit()
                    Text("피드")
                        .font(.system(size: 12))
                        .foregroundColor(selection == 0 ? Const.Colors.Gray2.color : Const.Colors.MainBlue.color)
                }.onTapGesture {
                    selection = 0
                }.tag(0)
            
            // TAB 2
            CollegeView()
                .tabItem {
                    selection == 1 ? Image("domain_active").resizable().frame(width: 32, height: 32, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).scaledToFit() : Image("domain").resizable().frame(width: 32, height: 32, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).scaledToFit()
                    Text("학과")
                        .font(.system(size: 12))
                        .foregroundColor(selection == 0 ? Const.Colors.Gray2.color : Const.Colors.MainBlue.color)
                }.onTapGesture {
                    selection = 1
                }.tag(1)
                .onAppear {
                    deptModel.initModel()
                }
            
            // TAB 3
            FavouriteListView()
                .tabItem {
                    selection == 2 ?
                        Image("favorite_selected").resizable().frame(width: 32, height: 32, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).scaledToFit() : Image("favorite_unselected").resizable().frame(width: 32, height: 32, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).scaledToFit()

                    Text("관심목록")
                        .font(.system(size: 12))
                        .foregroundColor(selection == 0 ? Const.Colors.Gray2.color : Const.Colors.MainBlue.color)
                }.onTapGesture {
                    selection = 2
                }.tag(2)
        } // End of tab view
        .zIndex(0)
        .navigationBarTitleDisplayMode(.inline)
        .environmentObject(deptModel)
        .environmentObject(settings)
        .toolbar {
            ToolbarItem(placement: .principal, content: {
                switch selection {
                case 0:
                    Image("horizontalLogo")
                case 1:
                    Text("팔로우")
                        .font(.system(size: 20))
                        .bold()
                case 2:
                    Text("관심목록")
                        .font(.system(size: 20))
                        .bold()
                default:
                    EmptyView()
                }
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
            
            ToolbarItem(placement: .navigationBarTrailing) {
                if selection == 0 {
                    HStack {
                        Text("")
                        NavigationLink(destination: FeedSearchView()) {
                            Image("search")
                        }
                    }
                }
            }
            
        } // end of toolbar
            

    } // End of Body
}

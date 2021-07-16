//
//  DepartmentDetailView.swift
//  snuboard
//
//  Created by Subeen Park on 2021/06/25.
//

import SwiftUI

struct DepartmentDetailView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var deptModel: DepartmentViewModel
    @EnvironmentObject var settings: Settings
    @StateObject var noticeModel: NoticeViewModel
    
    var id: Int
    var dept: Department {
        deptModel.depts.first { $0.id == id}!
    }
    @State var indexSelected: Int = 0
    
    init (id: Int) {
        self.id = id
        UINavigationBar.appearance().backgroundColor = .white
        _noticeModel = StateObject(wrappedValue: NoticeViewModel(id: id, type: .department))
    }
 

    
    var body: some View {
        
        
        VStack(spacing: 0) {
            
            SegmentedPickerView(selectedIndex: $indexSelected)
            if (indexSelected == 0) {
//                TagListView()
                DepartmentDetailHomeView(dept: dept)
                    .environmentObject(deptModel)
                    .environmentObject(settings)
                    .environmentObject(noticeModel)
            }
            else if (indexSelected == 1) {
                DepartmentDetailFeedView(dept: dept).environmentObject(deptModel)
            }
            Spacer()
            
            NavigationLink(destination: EmptyView()) {
                EmptyView()
            }
        }
        .background(Const.ColorSet.BgGray.color.edgesIgnoringSafeArea(.bottom))
        .navigationBarTitle(dept.name, displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Image("navigate_before").onTapGesture {
                    presentationMode.wrappedValue.dismiss()
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack(spacing: 5) {
                    if let url = URL(string: dept.link) {
                        Link(destination: url, label: {
                                Image("link")
                                    .renderingMode(.template)
                                    .foregroundColor(Const.ColorSet.Gray2.color)
                                    .frame(width: 24, height: 24, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        })
                    } else {
                        Image("link")
                            .renderingMode(.template)
                            .foregroundColor(Const.ColorSet.Gray2.color)
                            .frame(width: 24, height: 24, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }
                    
                    if indexSelected == 0 {
                        HStack {
                            Text("")
//                            NavigationLink(destination: DepartmentSearchView(dept: dept).environmentObject(settings)) {
//                                Image("search")
//                            }
                            NavigationLink(destination: DepartmentSearchView(dept: dept).environmentObject(settings),
                                           label: {
                                           Image("search")
                                           }).isDetailLink(false)
                            NavigationLink(destination: EmptyView()) {
                                EmptyView()
                            }
                        }
                    }
                    
                }
            }
        }
        
    }
}

struct DepartmentDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DepartmentDetailView(id: 1)
    }
}

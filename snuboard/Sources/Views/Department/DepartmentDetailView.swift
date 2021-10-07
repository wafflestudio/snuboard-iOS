//
//  DepartmentDetailView.swift
//  snuboard
//
//  Created by Subeen Park on 2021/09/10.
//

import SwiftUI


struct DepartmentDetailView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var deptModel: DepartmentListViewModel
    @EnvironmentObject var settings: Settings
    @StateObject private var noticeModel: NoticeViewModel
    
    let id: Int
    @State var indexSelected: Int = 0
    var dept: Department {
        deptModel.depts.first { $0.id == id }!
    }

    init(dept: Department) {
        self.id = dept.id
        let finalTags = UserDefaults.standard.queryParameters[dept.name] ?? []
        let noticeModelInit = NoticeViewModel(id: id, tags: finalTags.isEmpty ? dept.tags : finalTags)
        self._noticeModel = StateObject(wrappedValue: noticeModelInit)
        UIKit.UINavigationBar.appearance().backgroundColor = .white
    }
    

    var body: some View {


        VStack(spacing: 0) {

            SegmentedPickerView(selectedIndex: $indexSelected)
            if (indexSelected == 0) {
                DepartmentDetailFeedView(dept: dept)
                    .environmentObject(deptModel)
                    .environmentObject(settings)
            }
            else if (indexSelected == 1) {
                DepartmentDetailHomeView(dept: dept)
                    .environmentObject(deptModel)
                    .environmentObject(settings)
                    .environmentObject(noticeModel)
            }
            Spacer()

            NavigationLink(destination: EmptyView()) {
                EmptyView()
            }
        }
        .onAppear {
//            noticeModel.initModelWithDepartmentId(id: self.id)
        }
        .background(Const.Colors.BgGray.color.edgesIgnoringSafeArea(.bottom))
        .navigationBarTitle(dept.name, displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Image("navigateBefore").onTapGesture {
                    presentationMode.wrappedValue.dismiss()
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack(spacing: 5) {
                    if let url = URL(string: dept.link) {
                        Link(destination: url, label: {
                                Image("link")
                                    .renderingMode(.template)
                                    .foregroundColor(Const.Colors.Gray2.color)
                                    .frame(width: 24, height: 24, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        })
                    } else {
                        Image("link")
                            .renderingMode(.template)
                            .foregroundColor(Const.Colors.Gray2.color)
                            .frame(width: 24, height: 24, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }
                    

                }
            }
        }

    }
}

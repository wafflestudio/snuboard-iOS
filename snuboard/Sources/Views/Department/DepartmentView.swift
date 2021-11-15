//
//  DepartmentView.swift
//  snuboard
//
//  Created by Subeen Park on 2021/10/28.
//

import SwiftUI

struct DepartmentView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var dept: Department
    @State var indexSelected: Int = 0
    @EnvironmentObject var deptListModel: DepartmentListViewModel
    @StateObject var deptModel: DepartmentViewModel
    @EnvironmentObject var settings: Settings
    
    init(dept: Department) {
        self.dept = dept
        _deptModel = StateObject(wrappedValue: DepartmentViewModel(id: dept.id, name: dept.name))
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // PICKER
            SegmentedPickerView(selectedIndex: $indexSelected)
            if (indexSelected == 0) {

                DepartmentSettingView()
                    .environmentObject(deptModel)
                    .environmentObject(settings)
            }
            else if (indexSelected == 1) {
//                DepartmentDetailHomeView(dept: dept)
//                    .environmentObject(deptModel)
//                    .environmentObject(settings)
                DepartmentNoticeView()
                    .environmentObject(deptModel)
            }
            
            
            
        } // END OF VSTACK
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
        } // END OF TOOLBAR
    }
    
}


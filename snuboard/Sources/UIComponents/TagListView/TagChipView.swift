//
//  TagChipView.swift
//  snuboard
//
//  Created by Subeen Park on 2021/09/10.
//


import SwiftUI

struct TagChipView: View {
    
    
    let item: String
    @State var selected = false
    @Binding var notificationTurnedOn: Bool
    let id: Int

    
    @EnvironmentObject var deptModel: DepartmentListViewModel
    
    
    init (item: String, selected: Bool, id: Int, notificationTurnedOn: Binding<Bool>) {
        
        self.item = item
        self.selected = selected
        self.id = id
        self._notificationTurnedOn = notificationTurnedOn

        
    }
 
    var body: some View {

        Text(verbatim: item)
            .font(.system(size: 10))
            .foregroundColor(.white)
            .bold()
            .padding(5)
            .padding(.leading, 4)
            .padding(.trailing, 4)
            .background(
                RoundedRectangle(cornerRadius: 8)
                .fill(selected ? Const.Colors.MainBlue.color : Const.Colors.Unselected.color)
            )
            .onTapGesture {
                selected.toggle()
                if selected {
                    deptModel.createDepartmentFollow(id: id, follow: item)
                    if notificationTurnedOn {
                        deptModel.followTopic(deptId: id, topic: item)
                    }
                }
                else {
                    deptModel.deleteDepartmentFollow(id: id, follow: item)
                    if notificationTurnedOn {
                        deptModel.unfollowTopic(deptId: id, topic: item)
                    }
                }
            }
        
    }
}

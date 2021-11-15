//
//  DepartmentNoticeView.swift
//  snuboard
//
//  Created by Subeen Park on 2021/10/28.
//

import SwiftUI

struct DepartmentNoticeView: View {
    
    @EnvironmentObject var deptModel: DepartmentViewModel
    @EnvironmentObject var settings: Settings
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var appState = AppState.shared
    
    @State var searchText: String = ""
    
    var body: some View {
        
        ZStack {
            
            ScrollView {
                
                VStack(spacing: 0) { // VSTACK 0
                    
                    TagFilterView(searchText: $searchText)
                        .environmentObject(deptModel)
                        .environmentObject(settings)
                        .padding(12)
                        .background(RoundedRectangle(cornerRadius: 8).foregroundColor(.white))
                        .padding([.top, .leading, .trailing], 10)
                    
                    if !deptModel.notices.isEmpty || deptModel.nextCursor != "" || deptModel.loading {

                            VStack {
                                ForEach(deptModel.notices) { noticeSummary in
                                    NavigationLink(destination: DeptNoticeDetailView(id: noticeSummary.id), label: {
                                        DeptNoticeSummaryView(notice: noticeSummary)
                                    })
                                }
                                if !deptModel.noMoreContent && !deptModel.loading {
                                    HStack { // Load more Hstack
                                        Spacer()
                                        HStack {
                                            Button(action: {
                                                
                                                if searchText.count < 2 {
                                                    print("load ordinary notices")
                                                    deptModel.loadMoreNoticesByDepartmentId(tags: UserDefaults.standard.queryParameters[deptModel.department.name] ?? [])
                                                } else {
                                                    print("load search results")
                                                    deptModel.loadMoreSearchResultsByDepartmentId(tags: UserDefaults.standard.queryParameters[deptModel.department.name] ?? [], keywords: searchText)
                                                }
                                                
                                            }, label: {
                                                Text("더보기")
                                                    .foregroundColor(Const.Colors.MainBlue.color)
                                                    .font(.system(size: 14))
                                            })
                                            
                                        }
                                        Spacer()
                                    } // end of load more Hstack
                                }
                                
                            }.padding(10)
                            if deptModel.loading {
                                HStack {
                                    Spacer()
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle())
                                    Spacer()
                                }
                            }
                        
                        
                    }

                } // END OF VSTACK 0
                
            } // END OF SCROLL VIEW
            
            
            if deptModel.notices.isEmpty && deptModel.nextCursor == "" && !deptModel.loading {
                VStack {
                    Spacer()
                    Image("search_placeholder")
                        .resizable()
                        .frame(width: 203, height: 203, alignment: .center)
                }
            }

            
        }
        .background(Const.Colors.BgGray.color)
        .padding(.top, 1)

    }
}


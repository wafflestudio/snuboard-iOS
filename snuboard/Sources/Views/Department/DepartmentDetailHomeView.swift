//
//  DepartmentDetailHomeView.swift
//  snuboard
//
//  Created by Subeen Park on 2021/09/10.
//

import SwiftUI

struct DepartmentDetailHomeView: View {
    
    @EnvironmentObject var noticeModel: NoticeViewModel
    @EnvironmentObject var deptModel: DepartmentListViewModel
    @EnvironmentObject var settings: Settings
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var appState = AppState.shared
    
    
    @State var searchText: String = ""

    var dept: Department
    
    init(dept: Department) {
        self.dept = dept
//        _noticeModel = StateObject(wrappedValue: NoticeViewModel(id: dept.id, type: .department))
    }
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            if noticeModel.notices.isEmpty && !noticeModel.loading {
                PlaceHolderView("feed_placeholder")
            }
            else {
                
                ScrollView {
                    VStack {
                        ForEach(noticeModel.notices) { noticeSummary in
                            
    //                        NavigationLink(destination: NoticeSummaryView(notice: noticeSummary).environmentObject(noticeModel), isActive: $isShowingDetailView) { EmptyView() }
                            
                            NavigationLink(
                                destination: NoticeDetailView(id: noticeSummary.id).environmentObject(noticeModel),
                                isActive: .constant(appState.pageToNavigationTo==noticeSummary.id),
                                label: {
                                    NoticeSummaryView(notice: noticeSummary)
                                        .environmentObject(noticeModel)
                                        .onTapGesture {
                                            appState.pageToNavigationTo = noticeSummary.id
                                        }
                                })
                            
                        }
                        if !noticeModel.noMoreContent {
                            HStack { // Load more Hstack
                                Spacer()
                                HStack {
                                    Button(action: {
                                        noticeModel.loadMoreFollowingNotices()

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
                    if noticeModel.loading {
                        HStack {
                            Spacer()
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle())
                            Spacer()
                        }
                    }
                } // End of scroll view
                .padding(.top, 1)
                .background(Const.Colors.BgGray.color)
                
            }

        }
        
        
//        VStack {
//            // Follow-Chip
//            TagFilterView(deptId: dept.id, deptName: dept.name, tags: dept.tags, searchText: $searchText)
//                .environmentObject(settings)
//                .padding(12)
//                .background(RoundedRectangle(cornerRadius: 8).foregroundColor(.white))
//
//
//            ScrollView {
//                VStack {
//                    ForEach(noticeModel.notices) { noticeSummary in
//                        NoticeSummaryView(notice: noticeSummary).environmentObject(noticeModel)
//
//                    }
//                }
//
//                if !noticeModel.noMoreContent {
//                    HStack { // Load more Hstack
//                        Spacer()
//                        HStack {
//                            Button(action: {
//
//                                if searchText.count < 2 {
//                                    print("load ordinary notices")
//                                    noticeModel.loadMoreNoticesByDepartmentId(tags: UserDefaults.standard.queryParameters[dept.name] ?? [])
//                                } else {
//                                    print("load search results")
//                                    noticeModel.loadMoreSearchResultsByDepartmentId(tags: UserDefaults.standard.queryParameters[dept.name] ?? [], keywords: searchText)
//                                }
//
//
//                            }, label: {
//                                Text("더보기")
//                                    .foregroundColor(Const.Colors.MainBlue.color)
//                                    .font(.system(size: 14))
//                            })
//
//
//                        }
//                        Spacer()
//                    } // end of load more Hstack
//                }
//
//                if noticeModel.loading {
//
//                    HStack {
//                        Spacer()
//                        ProgressView()
//                            .progressViewStyle(CircularProgressViewStyle())
//                        Spacer()
//                    }
//
//                }
//
//
//            }
//
//
//
//            if noticeModel.notices.isEmpty && noticeModel.nextCursor == "" && !noticeModel.loading {
//                VStack {
//                    Spacer()
//                    Image("search_placeholder")
//                        .resizable()
//                        .frame(width: 203, height: 203, alignment: .center)
//                }
//            }
//
//        } // End of VStack
//        .onAppear {
//
//
//            settings.initUserDefaults()
////            print(settings.queryParameters)
////
////            let finalTags = UserDefaults.standard.queryParameters[dept.name] ?? []
////
////            noticeModel.initModelWithDepartmentId(id: self.dept.id, tags: finalTags.isEmpty ? self.dept.tags : finalTags)
//
//        }
//        .edgesIgnoringSafeArea(.bottom)
//        .padding([.top, .leading, .trailing], 10)
//        .background(Const.Colors.BgGray.color.ignoresSafeArea())
//        .navigationBarTitle(dept.name, displayMode: .inline)
//        .navigationBarBackButtonHidden(true)
        
        
        
    }
}

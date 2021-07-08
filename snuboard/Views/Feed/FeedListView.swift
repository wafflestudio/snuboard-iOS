//
//  FeedListView.swift
//  snuboard
//
//  Created by Subeen Park on 2021/07/09.
//

import SwiftUI

struct FeedListView: View {
    var body: some View {
        
        ZStack {
            PlaceHolderView()
            VStack(spacing: 0) {
                LogoTopBar()
                Divider()
                Spacer()
            }
        }

    }
}

struct FeedListView_Previews: PreviewProvider {
    static var previews: some View {
        FeedListView()
    }
}

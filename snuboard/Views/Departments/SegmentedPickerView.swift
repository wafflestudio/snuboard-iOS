//
//  SegmentedPickerView.swift
//  snuboard
//
//  Created by Subeen Park on 2021/06/25.
//

import SwiftUI

struct SegmentedPickerView: View {

    let titles: [String] = ["홈", "피드"]
    @Binding var selectedIndex: Int
    
    init(selectedIndex: Binding<Int>) {
        self._selectedIndex = selectedIndex
    }

    var body: some View {
        Picker("Numbers", selection: $selectedIndex) {
                        ForEach(0 ..< titles.count) { index in
                            Text(titles[index]).tag(index)
                        }
                    }
        .pickerStyle(SegmentedPickerStyle())
        .background(Color.white)
    }
    }

//struct SegmentedPickerView_Previews: PreviewProvider {
//    static var previews: some View {
//        SegmentedPickerView()
//    }
//}

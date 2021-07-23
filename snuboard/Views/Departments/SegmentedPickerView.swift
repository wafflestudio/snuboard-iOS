//
//  SegmentedPickerView.swift
//  snuboard
//
//  Created by Subeen Park on 2021/06/25.
//

// Reference 1: https://betterprogramming.pub/custom-ios-segmented-control-with-swiftui-473b386d0b51
// Reference 2: https://gist.github.com/frankfka/2784adff55be72a4f044d8c2bcc9fd3f

import SwiftUI

struct SegmentedPickerView: View {

    let titles: [String] = ["홈", "피드"]
    @Binding var selectedIndex: Int
    
    init(selectedIndex: Binding<Int>) {
        self._selectedIndex = selectedIndex
        UISegmentedControl.appearance().backgroundColor = .yellow
        
    }

    var body: some View {
        SegmentedPicker(items: titles, selection: $selectedIndex)
    }
}


// SegmentedPicker

extension View {
    func eraseToAnyView() -> AnyView {
        AnyView(self)
    }
}

struct PickerSizePreferenceKey: PreferenceKey {
    typealias Value = CGSize
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}
struct BackgroundGeometryReader: View {
    var body: some View {
        GeometryReader { geometry in
            return Color
                    .clear
                    .preference(key: PickerSizePreferenceKey.self, value: geometry.size)
        }
    }
}
struct SizeAwareViewModifier: ViewModifier {

    @Binding private var viewSize: CGSize

    init(viewSize: Binding<CGSize>) {
        self._viewSize = viewSize
    }

    func body(content: Content) -> some View {
        content
            .background(BackgroundGeometryReader())
            .onPreferenceChange(PickerSizePreferenceKey.self, perform: { if self.viewSize != $0 { self.viewSize = $0 }})
    }
}

struct SegmentedPicker: View {
    private static let ActiveSegmentColor: Color = .white
    private static let BackgroundColor: Color = .white
    private static let TextColor: Color = Const.ColorSet.Gray1.color
    private static let SelectedTextColor: Color = Const.ColorSet.Blue2.color
    private static let SegmentXPadding: CGFloat = 16
    private static let SegmentYPadding: CGFloat = 12
    private static let PickerPadding: CGFloat = 0
    
    private static let AnimationDuration: Double = 0
    
    // Stores the size of a segment, used to create the active segment rect
    @State private var segmentSize: CGSize = .zero
    // Rounded rectangle to denote active segment
    private var activeSegmentView: AnyView {
        // Don't show the active segment until we have initialized the view
        // This is required for `.animation()` to display properly, otherwise the animation will fire on init
        let isInitialized: Bool = segmentSize != .zero
        if !isInitialized { return EmptyView().eraseToAnyView() }
        return
            Rectangle()
                .foregroundColor(SegmentedPicker.ActiveSegmentColor)
                .frame(width: self.segmentSize.width, height: self.segmentSize.height)
                .padding([.bottom], 2)
                .background(Const.ColorSet.Blue2.color)
                .offset(x: self.computeActiveSegmentHorizontalOffset(), y: 0)
                .animation(Animation.linear(duration: SegmentedPicker.AnimationDuration))
                .eraseToAnyView()
    }
    
    @Binding private var selection: Int
    private let items: [String]
    
    init(items: [String], selection: Binding<Int>) {
        self._selection = selection
        self.items = items
    }
    
    var body: some View {
        // Align the ZStack to the leading edge to make calculating offset on activeSegmentView easier
        ZStack(alignment: .leading) {
            self.activeSegmentView
            HStack {
                ForEach(0..<self.items.count, id: \.self) { index in
                    self.getSegmentView(for: index)
                        .onTapGesture { self.onItemTap(index: index) }
                }
            }
        }
        .padding(SegmentedPicker.PickerPadding)
        .background(SegmentedPicker.BackgroundColor)
    }

    // Helper method to compute the offset based on the selected index
    private func computeActiveSegmentHorizontalOffset() -> CGFloat {
        CGFloat(self.selection) * (self.segmentSize.width + SegmentedPicker.SegmentXPadding / 2)
    }

    // Gets text view for the segment
    private func getSegmentView(for index: Int) -> some View {
        guard index < self.items.count else {
            return EmptyView().eraseToAnyView()
        }
        let isSelected = self.selection == index
        return
            Text(self.items[index])
                .font(.system(size: 14)).bold()
                .foregroundColor(isSelected ? SegmentedPicker.SelectedTextColor: SegmentedPicker.TextColor)
                .lineLimit(1)
                .padding(.vertical, SegmentedPicker.SegmentYPadding)
                .padding(.horizontal, SegmentedPicker.SegmentXPadding)
                .frame(minWidth: self.segmentSize.width, maxWidth: .infinity)
                .modifier(SizeAwareViewModifier(viewSize: self.$segmentSize))
                .eraseToAnyView()
    }

    // On tap to change the selection
    private func onItemTap(index: Int) {
        guard index < self.items.count else {
            return
        }
        self.selection = index
    }
    
}





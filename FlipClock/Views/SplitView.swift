//
//  SplitView.swift
//  FlipClock
//
//  Created by Pedro Ésli Vieira do Nascimento on 29/08/23.
//

import SwiftUI

struct SplitView<Content>: View where Content: View {
    
    @Binding var showSplitView: Bool
    @Binding var selectedViewOption: ViewOption
    let detail: Content
    @State private var visibility: NavigationSplitViewVisibility = .doubleColumn
    @State private var selectedMenuItem: ViewOption? = .clock
    private let menuItems = [
        MenuItem(id: .clock, title: Localization.SplitView.clock, iconName: ViewOption.clock.imageName),
        MenuItem(id: .stopwatch, title: Localization.SplitView.stopwatch, iconName: ViewOption.stopwatch.imageName),
        MenuItem(id: .timer, title: Localization.SplitView.timer, iconName: ViewOption.timer.imageName),
        MenuItem(id: .settings, title: Localization.SplitView.settings, iconName: ViewOption.settings.imageName)
    ]
    
    init(showSplitView: Binding<Bool>, selectedViewOption: Binding<ViewOption>, @ViewBuilder detail: () -> Content) {
        self._showSplitView = showSplitView
        self._selectedViewOption = selectedViewOption
        self.detail = detail()
    }
    
    var body: some View {
        NavigationSplitView(columnVisibility: $visibility) {
            List(menuItems, selection: $selectedMenuItem) { item in
                Label(item.title, systemImage: item.iconName)
            }
            .navigationSplitViewColumnWidth(150)
            #if os(iOS)
                .toolbar(.hidden, for: .navigationBar)
            #endif
        } detail: {
            ZStack {
                Asset.Colors.background.swiftUIColor.ignoresSafeArea()
                detail
                #if os(macOS)
                    .padding(.top, 20)
                    .padding(.bottom, 6)
                #endif
            }
            #if os(iOS)
                .toolbar(.hidden, for: .navigationBar)
            #endif
        }
        .navigationSplitViewStyle(.balanced)
        .onAppear {
            visibility = showSplitView ? .doubleColumn : .detailOnly
        }
        .onChange(of: showSplitView) { newValue in
            visibility = newValue ? .doubleColumn : .detailOnly
        }
        .onChange(of: selectedMenuItem) { newValue in
            guard let newValue, newValue != selectedViewOption else { return }
            selectedViewOption = newValue
        }
        .onChange(of: selectedViewOption) { newValue in
            guard newValue != selectedMenuItem else { return }
            selectedMenuItem = newValue
        }
    }
}

struct SplitView_Previews: PreviewProvider {
    
    static var previews: some View {
        SplitView(showSplitView: .constant(true), selectedViewOption: .constant(.clock)) {
            Text("Hello")
        }
        .tint(.green)
    }
}

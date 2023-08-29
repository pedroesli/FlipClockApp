//
//  StackView.swift
//  FlipClock
//
//  Created by Pedro Ésli Vieira do Nascimento on 29/08/23.
//

import SwiftUI

struct StackView<Content>: View where Content: View {
    
    @Binding var showAllViews: Bool
    @Binding var selectedViewOption: ViewOption
    let content: Content
    @State private var showSettingsView = false
    
    init(showAllViews: Binding<Bool>, selectedViewOption: Binding<ViewOption>, @ViewBuilder content: @escaping () -> Content) {
        self._showAllViews = showAllViews
        self._selectedViewOption = selectedViewOption
        self.content = content()
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Asset.Colors.background.swiftUIColor.ignoresSafeArea()
                GeometryReader { geometry in
                    VStack {
                        NavBar(safeAreaInsets: geometry.safeAreaInsets, showNavBar: $showAllViews) {
                            showSettingsView = true
                        }
                        content
                        TabBar(selectedTabOption: $selectedViewOption)
                            .offset(y: showAllViews ? 0 : geometry.safeAreaInsets.bottom + 200)
                            .frame(height: showAllViews ? nil : 0)
                    }
                }
            }
            .navigationDestination(isPresented: $showSettingsView) {
                ConfigurationView()
            }
        }
    }
}

struct StackView_Previews: PreviewProvider {
    
    @StateObject static var settingsManager = SettingsManager()
    
    static var previews: some View {
        StackView(showAllViews: .constant(true), selectedViewOption: .constant(.clock)) {
            Text("Hello, world")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .environmentObject(settingsManager)
    }
}

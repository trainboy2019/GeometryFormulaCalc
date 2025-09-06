//
//  LiquidGlassTestApp.swift
//  LiquidGlassTest
//
//  Created by James Rolader on 9/4/25.
//

import SwiftUI

@main
struct LiquidGlassTestApp: App {
    @StateObject private var unitsVM = UnitsModel()
    @StateObject private var settingsVM = SettingsModel()

    init() {
        #if os(iOS)
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        // Title colors
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        // If you want bar buttons to also be white:
        UINavigationBar.appearance().tintColor = .white

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        #endif
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(unitsVM)
                .environmentObject(settingsVM)
        }
        #if os(macOS)
        .windowStyle(.hiddenTitleBar)
        #endif
    }
}

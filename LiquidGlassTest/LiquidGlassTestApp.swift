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
                #if os(macOS)
                .navigationTitle("Geometry Formula Calculator")
                #endif
        }
        #if os(macOS)
        .windowStyle(.hiddenTitleBar)
        #endif
        .commands {
            // Remove default File menu groups
//            CommandGroup(replacing: .newItem) { }
//            CommandGroup(replacing: .saveItem) { }
//            CommandGroup(replacing: .printItem) { }
//            CommandGroup(replacing: .pasteboard) { }
            CommandGroup(replacing: .undoRedo) { }
//            CommandGroup(replacing: .textFormatting) { }
            CommandGroup(replacing: .systemServices) { }
            CommandGroup(replacing: .help) { }
            CommandGroup(replacing: .sidebar) { }

            // Keep only the "Copy" and "Select All" items for pasteboard
            CommandGroup(replacing: .pasteboard) {
                Button("Copy", systemImage: "document.on.document") {
                    NSApp.sendAction(#selector(NSText.copy(_:)), to: nil, from: nil)
                }
                .keyboardShortcut("c", modifiers: .command)

                Button("Select All", systemImage: "character.textbox") {
                    NSApp.sendAction(#selector(NSText.selectAll(_:)), to: nil, from: nil)
                }
                .keyboardShortcut("a", modifiers: .command)
            }
        }
    }
}



class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        if let mainMenu = NSApp.mainMenu {
            for item in mainMenu.items {
                if let submenu = item.submenu {
                    // Remove "Emoji & Symbols" and "Start Dictation…" from Edit menu
                    let itemsToRemove = submenu.items.filter {
                        $0.title.contains("Emoji") || $0.title.contains("Dictation")
                    }
                    for item in itemsToRemove {
                        submenu.removeItem(item)
                    }
                }
            }
        }
    }
}

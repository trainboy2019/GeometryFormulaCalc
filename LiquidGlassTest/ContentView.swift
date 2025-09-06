//
//  ContentView.swift
//  LiquidGlassTest
//
//  Created by James Rolader on 9/4/25.
//

import SwiftUI

struct ContentView: View {
    
#if os(macOS)
    @State private var preferredColumn: NavigationSplitViewColumn = .detail
#else
    @State private var preferredColumn: NavigationSplitViewColumn = .sidebar
#endif
    @State private var selectedPage: NavigationOptions? = nil
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationSplitView(preferredCompactColumn: $preferredColumn) {
            
            // Sidebar
            
            #if os(macOS)
            List(selection: $selectedPage) {
                Section {
                    ForEach(NavigationOptions.mainPages) { page in
                        NavigationLink(value: page) {
                            HStack {
                                if page == .areaoftrapezoid {
                                    HStack(alignment: .firstTextBaseline) {
                                        Label { Text(page.name) } icon: { Image("trapezoid.fill").renderingMode(.template) }
                                    }
                                } else {
                                    Label(page.name, systemImage: page.symbolName)
                                }
                            }
                        }
                    }
                }
            }
            .navigationDestination(for: NavigationOptions.self) { page in
                page.viewForPage()
            }
            .frame(minWidth: 225)
            #else
            if colorScheme == .light{
                List(selection: $selectedPage) {
                    Section {
                        ForEach(NavigationOptions.mainPages) { page in
                            NavigationLink(value: page) {
                                
                                HStack {
                                    if page == .areaoftrapezoid {
                                        HStack(alignment: .firstTextBaseline) {
                                            Label { Text(page.name) } icon: { Image("trapezoid.fill").renderingMode(.template) }
                                        }
                                    } else {
                                        Label(page.name, systemImage: page.symbolName)
                                    }
                                }
                            }
                        }
                    }
                }
                .listStyle(.sidebar)
                .scrollContentBackground(.hidden)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color(red: 243/255, green: 121/255, blue: 189/255),
                            Color(red: 224/255, green: 46/255, blue: 84/255)
                        ]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .ignoresSafeArea()
                )
                .navigationTitle("Area Calculator")
                .navigationDestination(for: NavigationOptions.self) { page in
                    page.viewForPage()
                }
                .frame(minWidth: 150)
            }
            else{
                List(selection: $selectedPage) {
                    Section {
                        ForEach(NavigationOptions.mainPages) { page in
                            NavigationLink(value: page) {
                                HStack {
                                    if page == .areaoftrapezoid {
                                        HStack(alignment: .firstTextBaseline) {
                                            Label { Text(page.name) } icon: { Image("trapezoid.fill").renderingMode(.template) }
                                        }
                                    } else {
                                        Label(page.name, systemImage: page.symbolName)
                                    }
                                }

                            }
                        }
                    }
                }
                .listStyle(.sidebar)
                .scrollContentBackground(.hidden)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color(red: 162/255, green: 62/255, blue: 119/255),
                            Color(red: 112/255, green: 23/255, blue: 51/255)
                        ]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .ignoresSafeArea()
                )
                .navigationTitle("Area Calculator")
                .navigationDestination(for: NavigationOptions.self) { page in
                    page.viewForPage()
                }
                .frame(minWidth: 150)
            }
            #endif
            
        } detail: {
            Group{
                if let selected = selectedPage {
                    selected.viewForPage()
                } else {
                    Text("Select a shape to begin.")
                        .font(.title)
                        .foregroundStyle(.secondary)
                }
            }
            .modifier(LightModeGradientBackground())
        }
    }
}


//import SwiftUI
//
//struct ContentView: View {
//    @Environment(\.colorScheme) var colorScheme
//    @EnvironmentObject var unitsVM: UnitsModel
//    @State private var preferredColumn: NavigationSplitViewColumn = .detail
//
//    var body: some View {
//
//        NavigationSplitView(preferredCompactColumn: $preferredColumn) {
//            List {
//                Section {
//                    ForEach(NavigationOptions.mainPages) { page in
//                        NavigationLink(value: page) {
//                            Label(page.name, systemImage: page.symbolName)
//                        }
//                    }
//                }
//            }
//            .navigationDestination(for: NavigationOptions.self) { page in
//                NavigationStack(path: NavigationPath()) {
//                    page.viewForPage()
//                }
//                .navigationDestination(for: Landmark.self) { landmark in
//                    LandmarkDetailView(landmark: landmark)
//                }
//                .navigationDestination(for: LandmarkCollection.self) { collection in
//                    CollectionDetailView(collection: collection)
//                }
//                .showsBadges()
//            }
//            .frame(minWidth: 150)
//        } detail: {
//            ZStack(alignment: .top) {
//                Color.black.edgesIgnoringSafeArea(.all)
//
//                if colorScheme == .light{
//                    LinearGradient(gradient: Gradient(colors: [Color.init(cgColor: .init(red: 243/255, green: 121/255, blue: 189/255, alpha: 1)), Color.init(cgColor: .init(red: 224/255, green: 46/255, blue: 84/255, alpha: 1))]), startPoint: .top, endPoint: .bottom)
//                    //                        .frame(height: 200)
//                        .edgesIgnoringSafeArea(.all)
//                }
////                ZStack {
//                            // Background Image
////                            Image("Image") // Replace "your_image_name" with your image's name
////                                .resizable()
////                                .scaledToFill()
////                                .ignoresSafeArea()
////                Text("BBB")
//                AreaOfCircleView()
//            }
//        }
//        // Adds the inspector, which the landmark detail view uses to display
//        // additional information.
////        .inspector(isPresented: Text("CCC")
//    }
//}

#Preview {
    
    ContentView()
        .environmentObject(UnitsModel())
    //        .onGeometryChange(for: CGSize.self) { geometry in
    //            geometry.size
    //        } action: {oldValue,newValue in
    ////            modelData.windowSize = $0
    //        }
    
}


struct LightModeGradientBackground: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    
    func body(content: Content) -> some View {
        ZStack {
            if colorScheme == .light {
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 243/255, green: 121/255, blue: 189/255),
                        Color(red: 224/255, green: 46/255, blue: 84/255)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            } else {
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 162/255, green: 62/255, blue: 119/255),
                        Color(red: 112/255, green: 23/255, blue: 51/255)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            }
            
            // Background Image
//            Image("Image") // Replace "your_image_name" with your image's name
//                .resizable()
//                .scaledToFill()
//                    .ignoresSafeArea()
            content
        }
        .ignoresSafeArea()
    }
}

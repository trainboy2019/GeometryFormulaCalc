//
//  NavigatorOptions.swift
//  LiquidGlassTest
//
//  Created by James Rolader on 9/5/25.
//

import SwiftUI

/// An enumeration of navigation options in the app.
enum NavigationOptions: Equatable, Hashable, Identifiable {
    case settings
    /// A case that represents viewing the app's landmarks, organized by continent.
    case areaofcircle
    /// A case that represents viewing the app's landmarks on a map.
    case areaoftriangle
    /// A case that represents viewing a person's favorite landmarks and other custom landmark collections.
    case areaofsquare
    case areaoftrapezoid
    case areaofregularpolygon
    case areaofsphere
    
    static let mainPages: [NavigationOptions] = [.settings, .areaofcircle, .areaoftriangle, .areaofsquare, .areaoftrapezoid, .areaofregularpolygon, .areaofsphere]
    
    var id: String {
        switch self {
        case .settings: return "Settings"
        case .areaofcircle: return "Area of a Circle"
        case .areaoftriangle: return "Area of a Triangle"
        case .areaofsquare: return "Area of a Rectangle"
        case .areaoftrapezoid: return "Area of a Trapezoid"
        case .areaofregularpolygon: return "Area of a Regular Polygon"
        case .areaofsphere: return "Surface Area of a Sphere"
        }
    }
    
    var name: LocalizedStringResource {
        switch self {
        case .settings: LocalizedStringResource("Settings", comment: "Change the settings of the app.")
        case .areaofcircle: LocalizedStringResource("Area of a Circle", comment: "Calculate the area of a circle via the radius or diameter.")
        case .areaoftriangle: LocalizedStringResource("Area of a Triangle", comment: "Calculate the area of a triangle via the base and height.")
        case .areaofsquare: LocalizedStringResource("Area of a Rectangle", comment: "Calculate the area of a rectangle via the base and height.")
        case .areaoftrapezoid: LocalizedStringResource("Area of a Trapezoid", comment: "Calculate the area of a trapezoid via the bases and height.")
        case .areaofregularpolygon: LocalizedStringResource("Area of a Regular Polygon", comment: "Calculate the area of a regular polygon via the number of sides and side length.")
        case .areaofsphere: LocalizedStringResource("Surface Area of a Sphere", comment: "Calculate the surface area of a sphere via the radius or diameter.")
        }
    }
    
    var symbolName: String {
        switch self {
        case .settings: "gear"
        case .areaofcircle: "circle.fill"
        case .areaoftriangle: "triangle.fill"
        case .areaofsquare: "rectangle.fill"
        case .areaoftrapezoid: "trapezoid.fill"
        case .areaofregularpolygon: "seal.fill"
        case .areaofsphere: "globe"
        }
    }
    
    /// A view builder that the split view uses to show a view for the selected navigation option.
    @MainActor @ViewBuilder
    func viewForPage() -> some View {
        switch self {
        case .settings:
            SettingsView()
                .modifier(LightModeGradientBackground())
        case .areaofcircle:
            AreaOfCircleView()
                .modifier(LightModeGradientBackground())
        case .areaoftriangle:
            AreaOfTriangleView()
                .modifier(LightModeGradientBackground())
        case .areaofsquare:
            AreaOfSquareView()
                .modifier(LightModeGradientBackground())
        case .areaoftrapezoid:
            AreaOfTrapezoidView()
                .modifier(LightModeGradientBackground())
        case .areaofregularpolygon:
            AreaOfRegularPolygonView()
                .modifier(LightModeGradientBackground())
        case .areaofsphere:
            AreaOfSphereView()
                .modifier(LightModeGradientBackground())
        }
    }

}

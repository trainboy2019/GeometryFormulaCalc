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
    case areaofcylinder
    case areaofcone
    case areaofcube
    case areaofpyramid
    case areaofellipse
    
    static let mainPages: [NavigationOptions] = [.settings, .areaofcircle, .areaoftriangle, .areaofsquare, .areaoftrapezoid, .areaofellipse, .areaofregularpolygon, .areaofsphere, .areaofcylinder, .areaofcone, .areaofcube, .areaofpyramid]
    
    var id: String {
        switch self {
        case .settings: return "Settings"
        case .areaofcircle: return "Area of a Circle"
        case .areaoftriangle: return "Area of a Triangle"
        case .areaofsquare: return "Area of a Rectangle"
        case .areaoftrapezoid: return "Area of a Trapezoid"
        case .areaofregularpolygon: return "Area of a Regular Polygon"
        case .areaofsphere: return "Surface Area of a Sphere"
        case .areaofcylinder: return "Surface Area of a Cylinder"
        case .areaofcone: return "Surface Area of a Cone"
        case .areaofcube: return "Surface Area of a Cube"
        case .areaofpyramid: return "Surface Area of a Pyramid"
        case .areaofellipse: return "Area of an Ellipse"
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
        case .areaofcylinder: LocalizedStringResource("Surface Area of a Cylinder", comment: "Calculate the surface area of a cylinder via the height, and the radius or diameter.")
        case .areaofcone: LocalizedStringResource("Surface Area of a Cone", comment: "Calculate the surface area of a cone via the height, and the radius or diameter.")
        case .areaofcube: LocalizedStringResource("Surface Area of a Cube", comment: "Calculate the surface area of a cube via the length, width, and height.")
        case .areaofpyramid: LocalizedStringResource("Surface Area of a Pyramid", comment: "Calculate the surface area of a pyramid via the length, width, and height.")
        case .areaofellipse: LocalizedStringResource("Area of an Ellipse", comment: "Calculate the area of an ellipse via the radius or diameter of the two axes.")
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
        case .areaofcylinder: "cylinder"
        case .areaofcone: "cone"
        case .areaofcube: "cube"
        case .areaofpyramid: "pyramid"
        case .areaofellipse: "oval"
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
        case .areaofcylinder:
            AreaOfCylinder()
                .modifier(LightModeGradientBackground())
        case .areaofcone:
            AreaOfCone()
                .modifier(LightModeGradientBackground())
        case .areaofcube:
            AreaOfCube()
                .modifier(LightModeGradientBackground())
        case .areaofpyramid:
            AreaOfPyramid()
                .modifier(LightModeGradientBackground())
        case .areaofellipse:
            AreaOfEllipse()
                .modifier(LightModeGradientBackground())
        }
    }

}

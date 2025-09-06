//
//  3DUnitsModel.swift
//  LiquidGlassTest
//
//  Created by James Rolader on 9/6/25.
//

import SwiftUI
import Combine
import Foundation

class UnitsModel3D: ObservableObject {
    @Published var inputLength: UnitLength = UnitLength.inches
    @Published var inputVolume: UnitVolume = UnitVolume.cubicInches
    @Published var outputLength: UnitLength = UnitLength.inches
    @Published var outputVolume: UnitVolume = UnitVolume.cubicInches
    @Published var inputUnit: String = "" {
        didSet {
            print("inputUnit changed to: \(inputUnit)")
            // You can do other logic here too
            inputUnitIndex=lengthOptions.firstIndex(of: inputUnit) ?? 0
            inputLength=lengths[inputUnitIndex]
            inputVolume=volumes[inputUnitIndex]
        }
    }
    @Published var outputUnit: String = "" {
        didSet {
            print("outputUnit changed to: \(outputUnit)")
            // You can do other logic here too
            outputUnitIndex=areaOptions.firstIndex(of: outputUnit) ?? 0
            outputLength=lengths[outputUnitIndex]
            outputVolume=volumes[outputUnitIndex]
        }
    }
    let lengths = [UnitLength.inches, UnitLength.feet, UnitLength.yards, UnitLength.miles, UnitLength.centimeters, UnitLength.meters, UnitLength.kilometers]
    let areas = [UnitArea.squareInches, UnitArea.squareFeet, UnitArea.squareYards, UnitArea.squareMiles, UnitArea.squareCentimeters, UnitArea.squareMeters, UnitArea.squareKilometers]
    let volumes = [UnitVolume.cubicInches, UnitVolume.cubicFeet, UnitVolume.cubicYards, UnitVolume.cubicMiles, UnitVolume.cubicCentimeters, UnitVolume.cubicMeters, UnitVolume.cubicKilometers]
    let lengthOptions =     ["Inches",   "Feet",  "Yards", "Miles",     "Centimeters",   "Meters",    "Kilometers" ]
    let areaOptions =       ["Square Inches",   "Square Feet",  "Square Yards", "Square Miles",     "Square Centimeters",   "Square Meters",    "Square Kilometers" ]
    let volumeOptions =       ["Cubic Inches",   "Cubic Feet",  "Cubic Yards", "Cubic Miles",     "Cubic Centimeters",   "Cubic Meters",    "Cubic Kilometers" ]
    var inputUnitIndex: Int = 0
    var outputUnitIndex: Int = 0

    
    init() {
        // Set default value here
        self.inputUnit = lengthOptions.first ?? ""
        self.outputUnit = areaOptions.first ?? ""
    }
}


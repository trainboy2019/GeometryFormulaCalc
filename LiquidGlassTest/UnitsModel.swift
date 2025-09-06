//
//  UnitsModel.swift
//  LiquidGlassTest
//
//  Created by James Rolader on 9/4/25.
//

import SwiftUI
import Combine
import Foundation

class UnitsModel: ObservableObject {
    @Published var inputLength: UnitLength = UnitLength.inches
    @Published var inputArea: UnitArea = UnitArea.squareInches
    @Published var outputLength: UnitLength = UnitLength.inches
    @Published var outputArea: UnitArea = UnitArea.squareInches
    @Published var inputUnit: String = "" {
        didSet {
            print("inputUnit changed to: \(inputUnit)")
            // You can do other logic here too
            inputUnitIndex=lengthOptions.firstIndex(of: inputUnit) ?? 0
            scaleFactor=lengthConversionTable[inputUnit+"→"+lengthOptions[outputUnitIndex]] ?? 1//conversionTable[inputUnitIndex][outputUnitIndex]
            inputLength=lengths[inputUnitIndex]
            inputArea=areas[inputUnitIndex]
        }
    }
    @Published var outputUnit: String = "" {
        didSet {
            print("outputUnit changed to: \(outputUnit)")
            // You can do other logic here too
            outputUnitIndex=areaOptions.firstIndex(of: outputUnit) ?? 0
            scaleFactor=lengthConversionTable[inputUnit+"→"+lengthOptions[outputUnitIndex]] ?? 1//conversionTable[inputUnitIndex][outputUnitIndex]
            outputLength=lengths[outputUnitIndex]
            outputArea=areas[outputUnitIndex]
        }
    }
    @Published var scaleFactor: Decimal = Decimal(string: "1.0")!
    let lengths = [UnitLength.inches, UnitLength.feet, UnitLength.yards, UnitLength.miles, UnitLength.centimeters, UnitLength.meters, UnitLength.kilometers]
    let areas = [UnitArea.squareInches, UnitArea.squareFeet, UnitArea.squareYards, UnitArea.squareMiles, UnitArea.squareCentimeters, UnitArea.squareMeters, UnitArea.squareKilometers]
    let lengthOptions =     ["Inches",   "Feet",  "Yards", "Miles",     "Centimeters",   "Meters",    "Kilometers" ]
    let areaOptions =       ["Square Inches",   "Square Feet",  "Square Yards", "Square Miles",     "Square Centimeters",   "Square Meters",    "Square Kilometers" ]
    var inputUnitIndex: Int = 0
    var outputUnitIndex: Int = 0

    var conversionTable: [[Double]]=[
                    [1,                 1/144,          1/1296,         1/4014489600,       6.4516,                 1/1550.0031000062,  1/1550003100.0062   ],
                    [144,               1,              1/9,            1/27878400,         929.0304,               1/10.76391041671,   1/10763910.41671    ],
                    [1296,              9,              1,              1/3097600,          8361.2736,              1/1.1959900463011,  1/1195990.0463011   ],
                    [4014489600,        27878400,       3097600,        1,                  25899881103.36,         2589988.110336,     2.589988110336      ],
                    [1/6.4516,          1/929.0304,     1/8361.2736,    1/25899881103.36,   1,                      1/10000,            1/10000000000       ],
                    [1550.0031000062,   10.76391041671, 1.1959900463011,1/2589988.110336,   10000,                  1,                  1/1000000           ],
                    [1550003100.0062,   10763910.41671, 1195990.0463011,1/2.589988110336,   10000000000,            1000000,            1                   ]
    ]
    let areaConversionTable: [String: Double] = [
        // Square Inches
        "Square Inches→Square Inches": 1.0,
        "Square Inches→Square Feet": 0.00694444,
        "Square Inches→Square Yards": 0.000771605,
        "Square Inches→Square Miles": 0.00000000039537,
        "Square Inches→Square Centimeters": 6.4516,
        "Square Inches→Square Meters": 0.00064516,
        "Square Inches→Square Kilometers": 0.00000000064516,
        
        // Square Feet
        "Square Feet→Square Inches": 144.0,
        "Square Feet→Square Feet": 1.0,
        "Square Feet→Square Yards": 0.111111,
        "Square Feet→Square Miles": 0.00000003587,
        "Square Feet→Square Centimeters": 929.0304,
        "Square Feet→Square Meters": 0.09290304,
        "Square Feet→Square Kilometers": 0.00000009290304,

        // Square Yards
        "Square Yards→Square Inches": 1296.0,
        "Square Yards→Square Feet": 9.0,
        "Square Yards→Square Yards": 1.0,
        "Square Yards→Square Miles": 0.00000032283,
        "Square Yards→Square Centimeters": 8361.2744,
        "Square Yards→Square Meters": 0.83612744,
        "Square Yards→Square Kilometers": 0.00000083612744,

        // Square Miles
        "Square Miles→Square Inches": 4014489600.0,
        "Square Miles→Square Feet": 27878400.0,
        "Square Miles→Square Yards": 3097600.0,
        "Square Miles→Square Miles": 1.0,
        "Square Miles→Square Centimeters": 25899881103.36,
        "Square Miles→Square Meters": 2589988.110336,
        "Square Miles→Square Kilometers": 2.589988110336,

        // Square Centimeters
        "Square Centimeters→Square Inches": 0.15500031,
        "Square Centimeters→Square Feet": 0.001076391,
        "Square Centimeters→Square Yards": 0.000119599,
        "Square Centimeters→Square Miles": 0.00000000003861,
        "Square Centimeters→Square Centimeters": 1.0,
        "Square Centimeters→Square Meters": 0.0001,
        "Square Centimeters→Square Kilometers": 0.0000000001,

        // Square Meters
        "Square Meters→Square Inches": 1550.0031,
        "Square Meters→Square Feet": 10.7639104,
        "Square Meters→Square Yards": 1.19599005,
        "Square Meters→Square Miles": 0.000000386102,
        "Square Meters→Square Centimeters": 10000.0,
        "Square Meters→Square Meters": 1.0,
        "Square Meters→Square Kilometers": 0.000001,

        // Square Kilometers
        "Square Kilometers→Square Inches": 1550003100.0,
        "Square Kilometers→Square Feet": 10763910.41671,
        "Square Kilometers→Square Yards": 1195990.0463,
        "Square Kilometers→Square Miles": 0.3861021585,
        "Square Kilometers→Square Centimeters": 10000000000.0,
        "Square Kilometers→Square Meters": 1000000.0,
        "Square Kilometers→Square Kilometers": 1.0
    ]
    
    

    let lengthConversionTable: [String: Decimal] = [
        // Identity
        "Inches→Inches": Decimal(1),
        "Feet→Feet": Decimal(1),
        "Yards→Yards": Decimal(1),
        "Miles→Miles": Decimal(1),
        "Centimeters→Centimeters": Decimal(1),
        "Meters→Meters": Decimal(1),
        "Kilometers→Kilometers": Decimal(1),
        
        // Inches to Others
        "Inches→Feet": Decimal(string: "0.083333333333")!,         // 1/12
        "Inches→Yards": Decimal(string: "0.027777777778")!,         // 1/36
        "Inches→Miles": Decimal(string: "0.000015782828")!,         // 1/63360
        "Inches→Centimeters": Decimal(string: "2.54")!,
        "Inches→Meters": Decimal(string: "0.0254")!,
        "Inches→Kilometers": Decimal(string: "0.0000254")!,

        // Feet to Others
        "Feet→Inches": Decimal(string: "12")!,
        "Feet→Yards": Decimal(string: "0.333333333333")!,
        "Feet→Miles": Decimal(string: "0.000189393939")!,
        "Feet→Centimeters": Decimal(string: "30.48")!,
        "Feet→Meters": Decimal(string: "0.3048")!,
        "Feet→Kilometers": Decimal(string: "0.0003048")!,

        // Yards to Others
        "Yards→Inches": Decimal(string: "36")!,
        "Yards→Feet": Decimal(string: "3")!,
        "Yards→Miles": Decimal(string: "0.000568181818")!,
        "Yards→Centimeters": Decimal(string: "91.44")!,
        "Yards→Meters": Decimal(string: "0.9144")!,
        "Yards→Kilometers": Decimal(string: "0.0009144")!,

        // Miles to Others
        "Miles→Inches": Decimal(string: "63360")!,
        "Miles→Feet": Decimal(string: "5280")!,
        "Miles→Yards": Decimal(string: "1760")!,
        "Miles→Centimeters": Decimal(string: "160934.4")!,
        "Miles→Meters": Decimal(string: "1609.344")!,  // ✅ The key value you care about
        "Miles→Kilometers": Decimal(string: "1.609344")!,

        // Centimeters to Others
        "Centimeters→Inches": Decimal(string: "0.3937007874")!,
        "Centimeters→Feet": Decimal(string: "0.032808399")!,
        "Centimeters→Yards": Decimal(string: "0.010936133")!,
        "Centimeters→Miles": Decimal(string: "0.00000621371")!,
        "Centimeters→Meters": Decimal(string: "0.01")!,
        "Centimeters→Kilometers": Decimal(string: "0.00001")!,

        // Meters to Others
        "Meters→Inches": Decimal(string: "39.37007874")!,
        "Meters→Feet": Decimal(string: "3.280839895")!,
        "Meters→Yards": Decimal(string: "1.093613298")!,
        "Meters→Miles": Decimal(string: "0.0006213711922")!,
        "Meters→Centimeters": Decimal(string: "100")!,
        "Meters→Kilometers": Decimal(string: "0.001")!,

        // Kilometers to Others
        "Kilometers→Inches": Decimal(string: "39370.07874")!,
        "Kilometers→Feet": Decimal(string: "3280.839895")!,
        "Kilometers→Yards": Decimal(string: "1093.613298")!,
        "Kilometers→Miles": Decimal(string: "0.6213711922")!,
        "Kilometers→Centimeters": Decimal(string: "100000")!,
        "Kilometers→Meters": Decimal(string: "1000")!
    ]




    
    
    init() {
        // Set default value here
        self.inputUnit = lengthOptions.first ?? ""
        self.outputUnit = areaOptions.first ?? ""
    }
}


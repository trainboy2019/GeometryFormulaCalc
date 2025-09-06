//
//  SettingsModel.swift
//  LiquidGlassTest
//
//  Created by James Rolader on 9/5/25.
//

import SwiftUI
import Combine
import Foundation

class SettingsModel: ObservableObject {
    @AppStorage("storedOutput") var storedOutput: String = "Auto"
    @Published var outputFormat: String = "Auto" {
        didSet {
            print("inputUnit changed to: \(outputFormat)")
            storedOutput=outputFormat
        }
    }
    let outputOptions = ["Auto", "Full number", "Pi notation"]
    
    init(){
        outputFormat=storedOutput
    }
}

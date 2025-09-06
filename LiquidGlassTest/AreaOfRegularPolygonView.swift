//
//  AreaOfRegularPolygonView.swift
//  LiquidGlassTest
//
//  Created by James Rolader on 9/5/25.
//

import SwiftUI

struct AreaOfRegularPolygonView: View {
    @AppStorage("storedOutput") var storedOutput: String = "Auto"
    @EnvironmentObject var unitsVM: UnitsModel

    // Inputs for a regular polygon
    @State private var sides: Int?
    @State private var sideLength: Double?

    // Result
    @State private var result: Double?
    @State private var resultText: String? = " "

    // Configuration (not currently used, but kept if you plan to add radius/apothem input later)
    @State private var isRadius: Bool = true

    private func calculate() {
        // Validate inputs
        let n = sides
        guard n ?? 0 >= 3 else {
            result = nil
            resultText = ""
            return
        }
        guard let rawSide = sideLength, rawSide > 0 else {
            result = nil
            resultText = ""
            return
        }

        // Convert side length from inputLength to outputLength
        let convertedSide = Measurement(value: rawSide, unit: unitsVM.inputLength)
            .converted(to: unitsVM.outputLength)
            .value

        // Compute area: A = (n * s^2) / (4 * tan(pi/n))
        let nDouble = Double(n ?? 0)
        let s = convertedSide
        let denominator = 4.0 * tan(.pi / nDouble)
        // Protect against any pathological tan(pi/n) = 0 (shouldn’t happen for n>=3)
        guard denominator != 0 else {
            result = nil
            resultText = ""
            return
        }
        let area = (nDouble * (s * s)) / denominator

        // Format result
        result = area
        switch storedOutput {
        case "Full number":
            let localized = area.formatted(
                .number
                    .precision(.fractionLength(3))
                    .locale(Locale.current)
            )
            resultText = String(localized)
        default:
            
            let formatted = area.formatted(
                .number
                    .notation(.scientific)
                    .precision(.fractionLength(3))
                    .locale(Locale.current)
            )
            
            var text = String(format: "%.3f", area)
            if text == "0.000" || text.count > 11 {
                text = String(format: "%.3e", area)
            }
            resultText = String(formatted)
        }

        // Append area units (e.g., "Square Feet")
        resultText = (resultText ?? "") + " " + unitsVM.outputUnit
    }

    var body: some View {
        VStack {
            Spacer()
            #if os(iOS)
            Text("Area of a Regular Polygon")
                .foregroundStyle(.white)
                .font(.title)
                .padding()
                .frame(minWidth: 300, idealWidth: 300, maxWidth: 300)
#else
Spacer()
            #endif

            HStack {
                // Number of sides
                TextField("Sides", value: $sides, format: .number)
                    .glassEffect(.clear)
                    .frame(minWidth: 80.0, idealWidth: 120.0, maxWidth: 160.0)
                    .onSubmit {
                        calculate()
                    }
                    .padding()

                // Side length
                TextField("Side Length", value: $sideLength, format: .number)
                    .glassEffect(.clear)
                    .frame(minWidth: 80.0, idealWidth: 120.0, maxWidth: 160.0)
                    .onSubmit {
                        calculate()
                    }
                    .padding()
            }

            Text("Calculate")
                .foregroundStyle(.white)
                .padding()
                .glassEffect(.clear.interactive())
                .frame(minWidth: 300, idealWidth: 300, maxWidth: 300)
                .onTapGesture {
                    calculate()
                }

            Spacer()

            HStack(alignment: .firstTextBaseline) {
                Text("Result: ").frame(width: 60, alignment: .leading)
                    .foregroundStyle(.white)
                ZStack(alignment: .leading) {
                    Text("Somereasonab")
                        .opacity(0)
                    Text(resultText ?? " ")
                        .foregroundStyle(.white)
                        .lineLimit(1)
                        .truncationMode(.tail)
                }
            }

            Spacer()
            UnitChangerView()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
        }
        .onReceive(unitsVM.$inputUnit) { _ in
            // Recalculate if inputs exist
            if sideLength != nil {
                DispatchQueue.main.async {
                    calculate()
                }
            }
        }
        .onReceive(unitsVM.$outputUnit) { _ in
            if sideLength != nil {
                DispatchQueue.main.async {
                    calculate()
                }
            }
        }
    }
}

#Preview {
    AreaOfRegularPolygonView()
        .environmentObject(UnitsModel())
}

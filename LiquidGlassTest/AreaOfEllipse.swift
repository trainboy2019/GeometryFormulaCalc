//
//  AreaOfEllipse.swift
//  LiquidGlassTest
//
//  Created by James Rolader on 9/8/25.
//

import SwiftUI

struct AreaOfEllipse: View {
    @AppStorage("storedOutput") var storedOutput: String = "Auto"
    @EnvironmentObject var unitsVM: UnitsModel
    @State private var axisA: Double?
    @State private var axisB: Double?
    @State private var result: Double?
    @State private var resultText: String? = " "
    @State private var isRadius: Bool = true
    
    func calculate() -> Void {
        var realAxisA=axisA
        var realAxisB=axisB
        if !isRadius {
            realAxisA=(realAxisA ?? 0)/2
            realAxisB=(realAxisB ?? 0)/2
        }
        let convertedAxisA=Measurement(value: realAxisA ?? 0, unit: unitsVM.inputLength).converted(to: unitsVM.outputLength).value
        let convertedAxisB=Measurement(value: realAxisB ?? 0, unit: unitsVM.inputLength).converted(to: unitsVM.outputLength).value
        switch storedOutput {
        case "Auto":
            result=(Double.pi*convertedAxisA*convertedAxisB)
            resultText=String(format: "%.3f", result ?? 0)
            if resultText=="0.000" || resultText!.count > 11 {
                resultText=String(format: "%.3e", result ?? 0)
            }
            resultText!+=" "+unitsVM.outputUnit
        case "Full number":
            result=(Double.pi*convertedAxisA*convertedAxisB)
            resultText=result?.description
            resultText!+=" "+unitsVM.outputUnit
        case "Pi notation":
            result=(convertedAxisA*convertedAxisB)
            resultText=String(format: "%.3f", result ?? 0)
            if resultText=="0.000" || resultText!.count > 11 {
                resultText=String(format: "%.3e", result ?? 0)
            }
            resultText!+="π "+unitsVM.outputUnit
        default:
            result=(Double.pi*convertedAxisA*convertedAxisB)
            resultText=String(format: "%.3f", result ?? 0)
            if resultText=="0.000" || resultText!.count > 11 {
                resultText=String(format: "%.3e", result ?? 0)
            }
            resultText!+=" "+unitsVM.outputUnit
        }
        
        if axisA==nil{
            resultText=""
        }
        if axisB==nil{
            resultText=""
        }
        
        
//        print(convertedRadius)
//        print(result)
//        print(storedOutput)
        
        
        
    }
    
    var body: some View {
            VStack{
                Spacer()
                #if os(iOS)
                Text("Area of a Circle")
                    .foregroundStyle(.white)
                    .font(.title)
//                    .glassEffect(.clear.interactive())
                    .padding()
                    .frame(minWidth: 300, idealWidth: 300, maxWidth: 300)
                #else
                Spacer()
                #endif
                HStack{
                    TextField(
                        "",
                        value: $axisA,
                        format: .number,
                        prompt: Text(isRadius ? "Radius of Axis A" : "Diameter of Axis A")
                            .foregroundColor(.white.opacity(0.5))
                            .italic()
                    )
                    .foregroundStyle(.white)
                    .glassEffect(.clear)
                    .frame(minWidth: 80.0, idealWidth: 120.0, maxWidth: 160.0)
                    .onSubmit {
                        print("From onSubmit")
                        calculate()
                    }
                    
                    TextField(
                        "",
                        value: $axisB,
                        format: .number,
                        prompt: Text(isRadius ? "Radius of Axis B" : "Diameter of Axis B")
                            .foregroundColor(.white.opacity(0.5))
                            .italic()
                    )
                    .foregroundStyle(.white)
                    .glassEffect(.clear)
                    .frame(minWidth: 80.0, idealWidth: 120.0, maxWidth: 160.0)
                    .onSubmit {
                        print("From onSubmit")
                        calculate()
                    }

                }
//                Button("Calculate") {
//                    calculate()
//                }
//                .padding()
//                .glassEffect(.clear)
//                .buttonStyle(.glass)
                
                    Text("Calculate")
                    .foregroundStyle(.white)
                    .padding()
                    .glassEffect(.clear.interactive())
                    .frame(minWidth: 300, idealWidth: 300, maxWidth: 300)
                    .onTapGesture {
                        calculate()
                    }
                    .background(Color.clear)
                    .contentShape(Rectangle())
                
                Spacer()
                HStack {
                    Toggle("", isOn: $isRadius)
                        .toggleStyle(.switch)
                        .tint(.clear)

                    // Static-width spacer or separate label avoids Toggle shifting
                    Text(isRadius ? "Calculate with Radius" : "Calculate with Diameter")
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding()
                .frame(minWidth: 300, idealWidth: 300, maxWidth: 300)
                HStack(alignment:.firstTextBaseline){
                    Text("Result: ").frame(width: 60, alignment: .leading)
                        .foregroundStyle(.white)
                    ZStack(alignment: .leading) {
                        // Invisible placeholder to reserve space
                        Text("Somereasonab")
                            .opacity(0)
                        
                        // Actual dynamic content
                        Text(resultText ?? " ")
                            .foregroundStyle(.white)
                            .lineLimit(1)
                            .truncationMode(.tail)
                            .textSelection(.enabled)
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
            .onReceive(unitsVM.$inputUnit) { newValue in
                print("scaleChanged")
                if axisA != nil && axisB != nil {
                    DispatchQueue.main.async {
                        print("From onReceive (deferred)")
                        calculate()
                    }
                }
            }
            .onReceive(unitsVM.$outputUnit) { newValue in
                print("scaleChanged")
                if axisA != nil && axisB != nil {
                    DispatchQueue.main.async {
                        print("From onReceive (deferred)")
                        calculate()
                    }
                }
            }
        }
    
}



#Preview {
    AreaOfEllipse()
        .environmentObject(UnitsModel())
}

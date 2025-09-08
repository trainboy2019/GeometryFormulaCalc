//
//  AreaOfPyramid.swift
//  LiquidGlassTest
//
//  Created by James Rolader on 9/8/25.
//

import SwiftUI

struct AreaOfPyramid: View {
    @AppStorage("storedOutput") var storedOutput: String = "Auto"
    @EnvironmentObject var unitsVM: UnitsModel
    @State private var base: Double?
    @State private var height: Double?
    @State private var width: Double?
    @State private var result: Double?
    @State private var resultText: String? = " "
    @State private var isRadius: Bool = true
    
    func calculate() -> Void {
        
        let convertedBase=Measurement(value: base ?? 0, unit: unitsVM.inputLength).converted(to: unitsVM.outputLength).value
        let convertedHeight=Measurement(value: height ?? 0, unit: unitsVM.inputLength).converted(to: unitsVM.outputLength).value
        let convertedWidth=Measurement(value: width ?? 0, unit: unitsVM.inputLength).converted(to: unitsVM.outputLength).value
        
        switch storedOutput {
        case "Full number":
            result=(convertedBase*convertedWidth)+(convertedBase*sqrt((pow((convertedWidth/2), 2)+pow(convertedHeight, 2))))+(convertedWidth*sqrt((pow(convertedWidth/2, 2))+pow(convertedHeight, 2)))
            resultText=String(format: "%.3f", result ?? 0)
        default:
            result=(convertedBase*convertedWidth)+(convertedBase*sqrt((pow((convertedWidth/2), 2)+pow(convertedHeight, 2))))+(convertedWidth*sqrt((pow(convertedWidth/2, 2))+pow(convertedHeight, 2)))
            resultText=String(format: "%.3f", result ?? 0)
            if resultText=="0.000" || resultText!.count > 11 {
                resultText=String(format: "%.3e", result ?? 0)
            }
        }
        
        resultText!+=" "+unitsVM.outputUnit
        
        if base==nil{
            resultText=""
        }
        if height==nil{
            resultText=""
        }
        if width==nil{
            resultText=""
        }
    }
    
    var body: some View {
            VStack{
                Spacer()
                #if os(iOS)
                Text("Surface Area of a Pyramid")
                    .foregroundStyle(.white)
                    .font(.title)
//                    .glassEffect(.clear.interactive())
                    .padding()
                    .frame(minWidth: 300, idealWidth: 300, maxWidth: 300)
#else
Spacer()
                #endif
                HStack{
                    TextField("Length", value: $base, format: .number)
                        .glassEffect(.clear)
                        .frame(minWidth: 80.0, idealWidth: 120.0, maxWidth: 160.0)
                        .onSubmit {
                            print("From onSubmit")
                            calculate()
                        }
                        .padding()
                    TextField("Height", value: $height, format: .number)
                        .glassEffect(.clear)
                        .frame(minWidth: 80.0, idealWidth: 120.0, maxWidth: 160.0)
                        .onSubmit {
                            print("From onSubmit")
                            calculate()
                        }
                        .padding()
                }
                TextField("Width", value: $width, format: .number)
                    .glassEffect(.clear)
                    .frame(minWidth: 80.0, idealWidth: 120.0, maxWidth: 160.0)
                    .onSubmit {
                        print("From onSubmit")
                        calculate()
                    }
                    .padding()
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
                if base != nil && height != nil && width != nil {
                    DispatchQueue.main.async {
                        print("From onReceive (deferred)")
                        calculate()
                    }
                }
            }
            .onReceive(unitsVM.$outputUnit) { newValue in
                print("scaleChanged")
                if base != nil && height != nil && width != nil {
                    DispatchQueue.main.async {
                        print("From onReceive (deferred)")
                        calculate()
                    }
                }
            }
        }
    
}



#Preview {
    AreaOfPyramid()
        .environmentObject(UnitsModel())
}

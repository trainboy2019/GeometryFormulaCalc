//
//  UnitChangerView.swift
//  LiquidGlassTest
//
//  Created by James Rolader on 9/4/25.
//

import SwiftUI

struct UnitChangerView: View {
    @EnvironmentObject var unitsVM: UnitsModel
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        HStack{
            
            
        }
        HStack {
            VStack{
                Text("Input Units")
                    .foregroundStyle(.white)
                Picker("Select Option", selection: $unitsVM.inputUnit) {
                    ForEach(unitsVM.lengthOptions, id: \.self) { option in
                        if colorScheme == .light{
                            Text(option)
                                .foregroundStyle(.white)
                        }else{
                            Text(option)
    //                            .foregroundStyle(.white)
                        }
                    }
                }
                .labelsHidden() // optional: hides "Select Option" label next to the picker
                .tint(.white)
                
#if os(macOS)
                .pickerStyle(MenuPickerStyle())
#else
                .pickerStyle(WheelPickerStyle())
#endif
            }
            VStack{
                Text("Output Units")
                    .foregroundStyle(.white)
                Picker("Select Option", selection: $unitsVM.outputUnit) {
                    ForEach(unitsVM.areaOptions, id: \.self) { option in
                        if colorScheme == .light{
                            Text(option)
                                .foregroundStyle(.white)
                        }else{
                            Text(option)
    //                            .foregroundStyle(.white)
                        }
                    }
                }
                .labelsHidden() // optional: hides "Select Option" label next to the picker
                .tint(.white)
                
#if os(macOS)
                .pickerStyle(MenuPickerStyle())
#else
                .pickerStyle(WheelPickerStyle())
#endif
            }
        }

    }
}

#Preview {
    UnitChangerView()
        .environmentObject(UnitsModel())
}

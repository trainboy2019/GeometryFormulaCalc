//
//  3DUnitChangerView.swift
//  LiquidGlassTest
//
//  Created by James Rolader on 9/6/25.
//

import SwiftUI

struct UnitChanger3DView: View {
    @EnvironmentObject var unitsVM: UnitsModel3D
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
                    ForEach(unitsVM.volumeOptions, id: \.self) { option in
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
    UnitChanger3DView()
        .environmentObject(UnitsModel3D())
}

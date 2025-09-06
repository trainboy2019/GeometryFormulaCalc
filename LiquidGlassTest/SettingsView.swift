//
//  SettingsView.swift
//  LiquidGlassTest
//
//  Created by James Rolader on 9/5/25.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var settingsVM: SettingsModel
    @Environment(\.colorScheme) var colorScheme
    @AppStorage("storedOutput") var storedOutput: String = "Auto"
    var body: some View {
        VStack{
            Spacer()
#if os(iOS)
            Text("Settings")
                .foregroundStyle(.white)
                .font(.title)
            //                    .glassEffect(.clear.interactive())
                .padding()
                .frame(minWidth: 300, idealWidth: 300, maxWidth: 300)
#else
            Spacer()
#endif
            
#if os(macOS)
            HStack {
                Text("Select output format:")
                    .foregroundStyle(.white)
                Picker("Select Option", selection: $settingsVM.outputFormat) {
                    ForEach(settingsVM.outputOptions, id: \.self) { option in
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
                
                
                .pickerStyle(MenuPickerStyle())
                
            }
#else
            VStack {
                Text("Select output format:")
                    .foregroundStyle(.white)
                Picker("Select Option", selection: $settingsVM.outputFormat) {
                    ForEach(settingsVM.outputOptions, id: \.self) { option in
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
                
                
                
                
                .pickerStyle(WheelPickerStyle())
                
            }
#endif
            
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(SettingsModel())
}

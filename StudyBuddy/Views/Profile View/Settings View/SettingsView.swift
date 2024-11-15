//
//  SettingsView.swift
//  StudyBuddy
//
//  Created by Pierce Oxley on 14/9/24.
//

import SwiftUI

struct SettingsView: View {
    // Property (key assigned name) usageAssignedName(local) type = default value
    @AppStorage("doVisualEffects") var doVisualEffects: Bool = true
    @AppStorage("preferredTheme") var preferredTheme: String = "Default"
    
    let themeChoices = ["Default", "OLED"]
    
    var body: some View {
        ZStack {
            Color.backgroundPrimary
                .ignoresSafeArea()
            
            ScrollView {
                Section("Appearance") {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .strokeBorder(Color.backgroundSecondary, lineWidth: 2)
                            .frame(height: 70)
                            .background(Color.clear)
                            .padding(.horizontal, 16)
                        
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Visual Effects")
                                Text("Enable visual effects like glows and blurs")
                                    .font(.caption)
                                
                            }
                            
                            Spacer()
                            
                            Toggle("", isOn: $doVisualEffects)
                                .frame(width: 50)
                            
                        }
                        .padding(.horizontal, 32)
                        
                    }
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .strokeBorder(Color.backgroundSecondary, lineWidth: 2)
                            .frame(height: 70)
                            .background(Color.clear)
                            .padding(.horizontal, 16)
                        
                        HStack {
                            VStack(alignment: .leading) {
                                Text("App Theme")
                                // Will also include light mode
                                Text("App color theme (Names in progress)")
                                    .font(.caption)

                            }
                            
                            Spacer()
                            
                            Picker("Theme", selection: $preferredTheme) {
                                ForEach(themeChoices, id: \.self) { theme in
                                    Text(theme)
                                    
                                }
                            }
                        }
                        .padding(.horizontal, 32)
                        
                    }
                }
            }
        }
    }
}

#Preview {
    SettingsView()
    
}

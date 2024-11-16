//
//  SettingsIconView.swift
//  StudyBuddy
//
//  Created by Pierce Oxley on 15/11/24.
//

import SwiftUI

struct SettingsIconView: View {
    var body: some View {
        if let image = UIImage(named: "settings")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 20, weight: .regular)) {
            ZStack {
                NavigationLink(destination: SettingsView()) {
                    Image(uiImage: image)
                        .renderingMode(.template)
                        .foregroundColor(.white)
                    
                }
            }
            
        } else {
            Text("Image not found")
                .foregroundColor(.red)
            
        }
    }
}

#Preview {
    SettingsIconView()
}

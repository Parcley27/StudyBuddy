//
//  ShareIconView.swift
//  StudyBuddy
//
//  Created by Pierce Oxley on 15/11/24.
//

import SwiftUI

struct ShareIconView: View {
    var body: some View {
        ShareLink(item: "Hello, Profile Sharing!") {
            if let image = UIImage(named: "ios_share")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 20, weight: .regular)) {
                ZStack {
                    Image(uiImage: image)
                        .renderingMode(.template)
                        .foregroundColor(Color.whitePrimary)
                        .padding(.bottom, 1) // Adjust for slightly lower SVG
                    
                }
                
            } else {
                Text("Image not found")
                    .foregroundColor(.red)
                
            }
        }
    }
}

#Preview {
    ShareIconView()
}

//
//  CloseIconView.swift
//  StudyBuddy
//
//  Created by Pierce Oxley on 15/11/24.
//

import SwiftUI

struct CloseIconView: View {
    var body: some View {
        if let image = UIImage(named: "close")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 24, weight: .regular)) {
            Button(action: {
                print("Close button tapped")
            }) {
                Image(uiImage: image)
                    .renderingMode(.template)
                    .foregroundColor(.white)
            }
            
        } else {
            Text("Image not found")
                .foregroundColor(.red)
            
        }
    }
}

#Preview {
    CloseIconView()
}

//
//  EditProfileView.swift
//  StudyBuddy
//
//  Created by Dale Dai on 2024-11-12.
//

import SwiftUI

struct EditProfileView: View {
    // Environment property to control the presentation mode
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            VStack {
                Text("Hello, Edit Profile View!")
                    .padding()
                // Additional content can go here
                
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Edit profile")
                        .font(.custom("Inter24pt-Bold", size: 16))
                        .foregroundColor(.primary)
                    
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                        
                    }) {
                        Text("Cancel")
                            .foregroundColor(.gray)
                            .font(.custom("Inter24pt-Bold", size: 16))
                        
                    }
                }
            }
        }
    }
}

#Preview {
    EditProfileView()
    
}

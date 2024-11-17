//
//  ProgressView.swift
//  StudyBuddy
//
//  Created by Pierce Oxley on 16/11/24.
//

import SwiftUI

struct ProgressView: View {
    @State var time: Double = 50
    @State var maxTime: Double = 100
    
    @State var maxWidth: CGFloat = 100
    @State var height: CGFloat = 5
    
    var body: some View {
        VStack(alignment: .trailing) {
            Text("\(Int(time)) of \(Int(maxTime)) hours")
                .font(.custom("Inter24pt-SemiBold", size: 16))
                .foregroundColor(.primary)
            
            ZStack(alignment: .leading) {
                Capsule()
                    .frame(width: maxWidth, height: height)
                    .foregroundStyle(Color.purpleSecondary)
                
                Capsule()
                    .frame(width: maxWidth * (time / maxTime), height: height)
                    .foregroundStyle(Color.purplePrimary)
                
            }
        }
    }
}

#Preview {
    @Previewable @State var time: Double = 50
    @Previewable @State var maxTime: Double = 100
    
    @Previewable @State var maxWidth: CGFloat = 300
    
    ProgressView(time: time, maxTime: maxTime, maxWidth: maxWidth)
    
}

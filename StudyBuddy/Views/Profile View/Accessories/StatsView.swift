//
//  StatsView.swift
//  StudyBuddy
//
//  Created by Pierce Oxley on 15/11/24.
//

import SwiftUI

struct StatsView: View {
    init(_ stat: String, _ emoji: String, _ caption: String) {
        self.stat = stat
        self.emoji = emoji
        self.caption = caption
        
    }
    
    @State var stat: String
    @State var emoji: String
    @State var caption: String
        
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text("\(stat) \(emoji)")
                .font(.custom("Inter24pt-SemiBold", size: 20))
            
            Text(caption)
                .font(.custom("Inter24pt-Regular", size: 14))
                .foregroundStyle(.secondary)
            
        }
        .padding(.top, 1)
        .frame(width: 70, alignment: .leading)
        
    }
}

#Preview {
    StatsView("100", "🔥", "Streak")
    
}

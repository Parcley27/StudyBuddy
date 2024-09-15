//
//  TabItemView.swift
//  StudyBuddy
//
//  Created by Pierce Oxley on 27/8/24.
//

import SwiftUI

struct TabItemView: View {
    init(_ tabName: String, _ iconName: String) {
        self.tabName = tabName
        self.iconName = iconName
        
    }
    
    let tabName: String
    let iconName: String
    
    var body: some View {
        VStack(spacing: 3) {
            Image(systemName: iconName)
                .font(.system(size: 24))
            
            Text(tabName)
                .font(.system(size: 10).weight(.semibold))
            
        }
    }
}

#Preview {
    TabItemView("Home", "house.fill")
    
}

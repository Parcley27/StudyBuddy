//
//  ColorExtensions.swift
//  StudyBuddy
//
//  Created by Pierce Oxley on 11/11/24.
//

import Foundation
import SwiftUI

extension Color {
    init(_ hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.hasPrefix("#") ? String(hexSanitized.dropFirst()) : hexSanitized

        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = Double((rgb >> 16) & 0xFF) / 255.0
        let green = Double((rgb >> 8) & 0xFF) / 255.0
        let blue = Double(rgb & 0xFF) / 255.0

        self.init(.sRGB, red: red, green: green, blue: blue, opacity: 1.0)
        
    }
    
    static let whitePrimary = Color("#FFFFFF")
    static let blackPrimary = Color("#000000")
    
    static let backgroundPrimary = Color("#1A1A1A")
    static let backgroundSecondary = Color("#3B3B3B")
    
    static let purplePrimary = Color("#3D4399")
    static let purpleSecondary = Color("#282A3E")
    
    static let greyPrimary = Color("#7C7C7C")
//    static let greySecondary = Color("#77777A")
    // ^^ Use .secondary instead
    
}

// Usage:
//let color = Color("#FF5733")

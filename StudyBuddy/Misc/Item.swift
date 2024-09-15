//
//  Item.swift
//  StudyBuddy
//
//  Created by Pierce Oxley on 2024-06-21.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}

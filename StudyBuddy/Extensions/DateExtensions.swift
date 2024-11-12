//
//  DateExtensions.swift
//  StudyBuddy
//
//  Created by Pierce Oxley on 11/11/24.
//

import Foundation

extension Date {
    func minusDays(_ days: Int) -> Date? {
        return Calendar.current.date(byAdding: .day, value: -days, to: self)
        
    }
}

// Usage:
//let today = Date()
//if let newDate = today.minusDays(5) {
//    print("5 days ago: \(newDate)")
//
//}

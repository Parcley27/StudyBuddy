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
    
    static func makeDate(years: Int? = nil, months: Int? = nil, days: Int? = nil, hours: Int? = nil, minutes: Int? = nil, seconds: Int? = nil) -> Date {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(secondsFromGMT: -8 + 60 + 60)!
        
        let components = DateComponents(year: years, month: months, day: days, hour: hours, minute: minutes, second: seconds)
        return calendar.date(from: components)!
        
    }
    
    var longFormat: String {
        let formatter = DateFormatter()
        
        formatter.dateStyle = .long
        formatter.timeStyle = .medium
        
        return formatter.string(from: self)
        
    }
    
    var mediumFormat: String {
        let formatter = DateFormatter()
        
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        return formatter.string(from: self)
        
    }
    
    var shortFormat: String {
        let formatter = DateFormatter()
        
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        
        return formatter.string(from: self)
        
    }
    
    var daysAgoDescription: String {
        let calendar = Calendar.current
        let now = Date()
        
        guard let daysDifference = calendar.dateComponents([.day], from: self, to: now).day else {
            return "Error calculating"
            
        }
        
        switch daysDifference {
        case 0:
            return "Today"
            
        case 1:
            return "Yesterday"
            
        default:
            return "\(daysDifference) days ago"
            
        }
    }
}

// Usage:
//let today = Date()
//if let newDate = today.minusDays(5) {
//    print("5 days ago: \(newDate)")
//
//}

//let givenDate = Date.makeDate(years: 202, months: 1, days: 1, hours: 1, minutes: 1, seconds: 1)
//print("Given date: \(givenDate)")

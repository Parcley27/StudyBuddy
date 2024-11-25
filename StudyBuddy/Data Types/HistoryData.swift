//
//  HistoryData.swift
//  StudyBuddy
//
//  Created by Pierce Oxley on 11/11/24.
//

import Foundation

struct HistoryData: Identifiable {
    let date: Date
    
    let minutesStudied: Int
    
    let id = UUID()
    
    static func formatData(data: [HistoryData], length: Int) -> [HistoryData] {
        // Take only last year of data (sourced from profile)
        let newData: [HistoryData] = Array(data.prefix(365))
        
        // If length is small enough, that portion of the data is OK
        if length <= 31 {
            return newData.suffix(length)
        } else {
            // return a "summarized" set of data if there are too many days to individually plot (Takes averages of groups of data)
            let summarizedData = summarizeData(data: newData)
            
            return summarizedData
            
        }
    }
            
    static func maxMinutesStudied(_ data: [HistoryData]) -> (Int) {
        return (data.max(by: { $0.minutesStudied < $1.minutesStudied })?.minutesStudied ?? 0)
        
    }
    
    static func averageMinutesStudied(data: [HistoryData], range: Int) -> Double {
        let newData = Array(data.prefix(range))
        guard !newData.isEmpty else { return 0 } // Avoid division by zero
        let total = newData.reduce(0) { $0 + $1.minutesStudied }
        return Double(total) / Double(range)
    }
}

func summarizeData(data: [HistoryData]) -> [HistoryData] {
    var monthlyData: [Int: [HistoryData]] = [:] // group into months

    let calendar = Calendar.current

    // Group data by month
    for entry in data {
        let month = calendar.component(.month, from: entry.date) // Get the month component
        monthlyData[month, default: []].append(entry)
    }

    // Create a new list of averaged values
    var averagedData: [HistoryData] = []

    for month in 1...12 {
        guard let entries = monthlyData[month], !entries.isEmpty else {
            continue
        }

        // Calculate average of minutesStudied for the month
        let totalHours = entries.reduce(0) { $0 + $1.minutesStudied }
        let averageHours = totalHours / entries.count

        // Pick the date of the first entry as the representative date for the month
        let representativeDate = entries.first!.date

        // Add the averaged data to the new list
        averagedData.append(HistoryData(date: representativeDate, minutesStudied: averageHours))
    }

    return averagedData
}

//
//  HistoryChartData.swift
//  StudyBuddy
//
//  Created by Pierce Oxley on 11/11/24.
//

import Foundation

extension Date {
    static func from(year: Int, month: Int, day: Int) -> Date {
        let components = DateComponents(year: year, month: month, day: day)
        return Calendar.current.date(from: components)!
    }
}

func summarizeData(data: [HistoryChartData]) -> [HistoryChartData] {
    var monthlyData: [Int: [HistoryChartData]] = [:] // group into months

    let calendar = Calendar.current

    // Group data by month
    for entry in data {
        let month = calendar.component(.month, from: entry.date) // Get the month component
        monthlyData[month, default: []].append(entry)
    }

    // Create a new list of averaged values
    var averagedData: [HistoryChartData] = []

    for month in 1...12 {
        guard let entries = monthlyData[month], !entries.isEmpty else {
            continue
        }

        // Calculate average of hoursStudied for the month
        let totalHours = entries.reduce(0) { $0 + $1.hoursStudied }
        let averageHours = totalHours / entries.count

        // Pick the date of the first entry as the representative date for the month
        let representativeDate = entries.first!.date

        // Add the averaged data to the new list
        averagedData.append(HistoryChartData(date: representativeDate, hoursStudied: averageHours))
    }

    return averagedData
}

struct HistoryChartData: Identifiable {
    let date: Date
    
    let hoursStudied: Int
    
    let id = UUID()
    
    static func createData(_ length: Int) -> [HistoryChartData] {
        var newData: [HistoryChartData] = []
        
        // Generate a random set of a full year of data in minutes
        let calendar = Calendar.current
        let startDate = calendar.date(from: DateComponents(year: 2024, month: 1, day: 1))!
        for i in 0..<365 {
            let date = calendar.date(byAdding: .day, value: i, to: startDate)!
            newData.append(HistoryChartData(date: date, hoursStudied: (Int.random(in: 10...300)/60))) // data is originally in minutes
        }
        
        // Take only last year of data
        newData = Array(newData.prefix(365))
        
        // If length is small enough, that portion of the data is OK
        if length <= 31 {
            return newData.suffix(length)
        } else {
            // return a "summarized" set of data if there are too many days to individually plot (Takes averages of groups of data)
            let summarizedData = summarizeData(data: newData)
            
            return summarizedData
        }
    }
    
    static func maxMinutesStudied(_ data: [HistoryChartData]) -> (Int) {
        return (data.max(by: { $0.hoursStudied < $1.hoursStudied })?.hoursStudied ?? 0)
    }
}


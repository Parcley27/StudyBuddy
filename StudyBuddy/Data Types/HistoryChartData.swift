//
//  HistoryChartData.swift
//  StudyBuddy
//
//  Created by Pierce Oxley on 11/11/24.
//

import Foundation

struct HistoryChartData: Identifiable {
    let date: Date
    
    let minutesStudied: Int
    
    let id = UUID()
    
    static func mockData(_ length: Int) -> [HistoryChartData] {
        var mockData: [HistoryChartData] = []
        
        for i in 0 ... length - 1 {
            mockData.append(HistoryChartData(date: Date().minusDays(i) ?? Date(), minutesStudied: Int.random(in: 0 ... 300)))
            
        }
        
        return mockData
            
    }
    
}

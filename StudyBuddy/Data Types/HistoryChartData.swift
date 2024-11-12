//
//  ChartHistoryData.swift
//  StudyBuddy
//
//  Created by Pierce Oxley on 11/11/24.
//

import Foundation

struct ChartHistoryData: Identifiable {
    let date: Date
    
    let minutesStudied: Int
    var hoursStudied: Double {
        return Double(minutesStudied) / 60.0
        
    }
    
    let id = UUID()
    
}

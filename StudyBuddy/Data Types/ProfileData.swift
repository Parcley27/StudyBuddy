//
//  ProfileData.swift
//  StudyBuddy
//
//  Created by Pierce Oxley on 12/11/24.
//

import Foundation

struct ProfileData {
    var name: String
    var username: String
    
    var level: Int
    var streak: Int
    var totalHours: Int
    
    var rank: String
    var rankEmoji: String
    
    var aboutMe: String
    
    var joinDate: Date
    
    var historyData: [HistoryData]
    
    static let mock: ProfileData = {
        let mockName: String = "Pierce Oxley"
        let mockUsername: String = "greenpowderranger"
        
        let mockLevel: Int = 30
        let mockStreak: Int = 70
        let mockTotalHours: Int = 100
        
        let mockRank: String = "Scholar"
        let mockRankEmoji: String = "🎓"
        
        let mockAboutMe: String = "Hi everyone! My name is Pierce and I love horses, especially Polish ones. I also enjoy iOS development in my free time."
        
        let mockJoinDate = Date.makeDate(years: 2024, months: 6, days: 21, hours: 12)
        
        var newData: [HistoryData] = []
                
        // Generate a random set of a full year of data in minutes
        let calendar = Calendar.current
        let startDate = calendar.date(from: DateComponents(year: 2024, month: 1, day: 1))!
        for i in 0..<365 {
            let date = calendar.date(byAdding: .day, value: i, to: startDate)!
            newData.append(HistoryData(date: date, minutesStudied: (Int.random(in: 10...300))))
        }
        
        return ProfileData(
            name: mockName,
            username: mockUsername,
            
            level: mockLevel,
            streak: mockStreak,
            totalHours: mockTotalHours,
            
            rank: mockRank,
            rankEmoji: mockRankEmoji,
            
            aboutMe: mockAboutMe,
            
            joinDate: mockJoinDate,
            
            historyData: newData
            
        )
            
    }()
    
}

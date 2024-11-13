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
    
    static func mockData() -> ProfileData {
        let mockName: String = "Pierce Oxley"
        let mockUsername: String = "greenpowderranger"
        
        let mockLevel: Int = 30
        let mockStreak: Int = 70
        let mockTotalHours: Int = 100
        
        let mockRank: String = "Scholar"
        let mockRankEmoji: String = "🎓"
        
        let mockAboutMe: String = "Hi everyone! My name is Pierce and I love horses, especially Polish ones. I also enjoy iOS development in my free time."
        
        let mockJoinDate = Date.makeDate(years: 2024, months: 6, days: 21, hours: 12)
        
        let mockData = ProfileData(
            name: mockName,
            username: mockUsername,
            
            level: mockLevel,
            streak: mockStreak,
            totalHours: mockTotalHours,
            
            rank: mockRank,
            rankEmoji: mockRankEmoji,
            
            aboutMe: mockAboutMe,
            
            joinDate: mockJoinDate
            
        )
        
        return mockData
            
    }
    
}

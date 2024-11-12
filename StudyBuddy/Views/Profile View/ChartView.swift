//
//  ChartView.swift
//  StudyBuddy
//
//  Created by Pierce Oxley on 11/11/24.
//

import SwiftUI
import Charts

struct ChartView: View {
    var height: Int = 250
    var days: Int = 7
    
    @State var ChartData: [HistoryChartData]
    
    init(height: Int = 250, days: Int = 7) {
        self.height = height
        self.days = days
        
        _ChartData = State(initialValue: HistoryChartData.mockData(days))
        
    }
          
    var body: some View {
        Chart {
            ForEach(ChartData, id: \.id) { sessionHistory in
                BarMark(
                    x: .value("Date", sessionHistory.date),
                    y: .value("Session Length", sessionHistory.minutesStudied)
                    
                )
                .foregroundStyle(Color("3D4399"))
                
            }
        }
        .frame(height: CGFloat(height))
        
    }
}

#Preview {
    ChartView()
    
}

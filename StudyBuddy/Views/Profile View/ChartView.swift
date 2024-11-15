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
    
    @Binding var daysToShow: Int
    
    @State private var chartData: [HistoryChartData] = []
    
    var body: some View {
        Chart {
            ForEach(chartData, id: \.id) { sessionHistory in
                BarMark(
                    x: .value("Date", sessionHistory.date, unit: .day),
                    y: .value("Session Length", Double(sessionHistory.minutesStudied) / 60.0)
                )
                .cornerRadius(5)
                .foregroundStyle(Color.purplePrimary)
                // Lighter tips
                //.foregroundStyle(Color.purplePrimary.gradient)
                
            }
        }
        .frame(height: CGFloat(height))
        .onAppear {
            chartData = HistoryChartData.mockData(daysToShow)
            
        }
        .onChange(of: daysToShow) {
            chartData = HistoryChartData.mockData(daysToShow)
            
        }
    }
}

#Preview {
    @Previewable @State var daysToShow: Int = 10
    
    let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    
    ChartView(daysToShow: $daysToShow)
        .onReceive(timer) { _ in
            daysToShow = Int.random(in: 1 ... 10)
            
        }
}

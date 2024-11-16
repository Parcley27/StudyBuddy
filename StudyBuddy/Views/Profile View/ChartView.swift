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
        .chartXAxis {
            if daysToShow == 7 {
                AxisMarks(values: chartData.map { $0.date }) { date in
                    AxisValueLabel(format: .dateTime.weekday(), centered: true)
                }
            } else if daysToShow == 30 {
                // Label every 5th bar for 30 days
                AxisMarks(values: chartData.indices.filter { $0 % 5 == 0 }.map { chartData[$0].date }) { date in
                    AxisValueLabel(format: .dateTime.month(.abbreviated).day(), centered: true)
                }
            } else if daysToShow == 60 {
                // Label every 10th bar for 60 days
                AxisMarks(values: chartData.indices.filter { $0 % 10 == 0 }.map { chartData[$0].date }) { date in
                    AxisValueLabel(format: .dateTime.month(), centered: true)
                }
            } else {
                AxisMarks(values: chartData.map { $0.date }) { date in
                    AxisValueLabel(format: .dateTime.month(.narrow), centered: true)
                }
            }
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

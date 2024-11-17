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
    @Binding var averageStudyTime: Double
    
    @Binding var chartData: [HistoryData]
    
    var body: some View {
        Chart {
            RuleMark(y: .value("Average", (averageStudyTime / 60.0)))
                .foregroundStyle(Color.purpleSecondary)
                .lineStyle(StrokeStyle(lineWidth: 1))
            
            
            ForEach(chartData.prefix(daysToShow), id: \.id) { sessionHistory in
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
        .chartXAxis {
            if daysToShow <= 7 {
                AxisMarks(values: chartData.prefix(daysToShow).map { $0.date }) { date in
                    AxisTick()
                    AxisValueLabel(format: .dateTime.weekday())
                    
                }
                
            } else if daysToShow <= 31 {
                AxisMarks(values: chartData.prefix(daysToShow).indices.filter { index in
                    index % 5 == 0 || index == (daysToShow - 1)
                    
                }.map { chartData.prefix(daysToShow)[$0].date }) { date in
                    AxisTick()
                    
                    AxisValueLabel(format: .dateTime.month(.abbreviated).day())
                    
                }
                
            } else {
                AxisMarks(values: chartData.prefix(daysToShow).indices.filter { index in
                    Calendar.current.component(.day, from: chartData[index].date) == 1 || index == (daysToShow - 1)
                    
                }.map { chartData.prefix(daysToShow)[$0].date }) { date in
                    AxisTick()
                    
                    AxisValueLabel(format: .dateTime.month())
                    
                }
                
            }
        }
        .chartYAxis {
            AxisMarks() { value in
                AxisValueLabel {
                    if let number = value.as(Double.self) {
                        Text("\(Int(number))h")
                        
                    }
                }
            }
        }
        .onAppear {
            averageStudyTime = chartData.isEmpty ? 0.0 : Double(chartData.map { $0.minutesStudied }.reduce(0, +) / chartData.count)
            
        }
        .onChange(of: daysToShow) {
            averageStudyTime = chartData.isEmpty ? 0.0 : Double(chartData.map { $0.minutesStudied }.reduce(0, +) / chartData.count)
            
        }
    }
}

#Preview {
    @Previewable @State var daysToShow: Int = 7
    @Previewable @State var averageStudyTime: Double = 0
    
    @Previewable @State var chartData: [HistoryData] = ProfileData.mockData().historyData
    
    let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    
    ChartView(daysToShow: $daysToShow, averageStudyTime: $averageStudyTime, chartData: $chartData)
        .onReceive(timer) { _ in
            daysToShow = Int.random(in: 5 ... 7)
            
        }
}

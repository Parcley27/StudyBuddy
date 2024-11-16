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
            if daysToShow <= 7 {
                AxisMarks(values: chartData.map { $0.date }) { date in
                    AxisTick()

                    AxisValueLabel(format: .dateTime.weekday())
                    
                }
                
            } else if daysToShow <= 31 {
                AxisMarks(values: chartData.indices.filter { index in
                    index % 5 == 0 || index == (daysToShow - 1)
                    
                }.map { chartData[$0].date }) { date in
                    AxisTick()
                    
                    AxisValueLabel(format: .dateTime.month(.abbreviated).day())
                    
                }
                
            } else {
                AxisMarks(values: chartData.indices.filter { index in
                    Calendar.current.component(.day, from: chartData[index].date) == 1 || index == (daysToShow - 1)
                    
                }.map { chartData[$0].date }) { date in
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
    @Previewable @State var daysToShow: Int = 10
    
    let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    
    ChartView(daysToShow: $daysToShow)
        .onReceive(timer) { _ in
            daysToShow = Int.random(in: 5 ... 7)
            
        }
}

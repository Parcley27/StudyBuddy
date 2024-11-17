//
//  ChartView.swift
//  StudyBuddy
//
//  Created by Pierce Oxley on 11/11/24.
//

import SwiftUI
import Charts

struct ChartView: View {
    // Set graph colors (for gradient) and height
    var height: Int = 250
    var colors = [Color("E39FF6"), Color("710193"), Color.purple]

    // Parameters
    @Binding var daysToShow: Int
    @Binding var averageStudyTime: Double
        
    var body: some View {
        let chartData: [HistoryChartData] = HistoryChartData.createData(daysToShow)
        // Color gradient to use
        let curGradient = LinearGradient(
            gradient: Gradient (
                colors: [
                    colors[0],
                    colors[1],
                    colors[2]
                ]
            ),
            startPoint: .leading,
            endPoint: .bottom
        )
        
        VStack {
            Chart {
                
                ForEach(chartData) { viewMonth in
                    // Different x-axis units depending on range
                    if daysToShow <= 7 {
                        LineMark(
                            x: .value("Day", viewMonth.date, unit: .weekday),
                            y: .value("Hours Studied", viewMonth.hoursStudied)
                        )
                        .interpolationMethod(.catmullRom)
                        .lineStyle(.init(lineWidth: 3))
                        .foregroundStyle(curGradient)
                    } else if daysToShow <= 31 {
                        LineMark(
                            x: .value("Date", viewMonth.date, unit: .day),
                            y: .value("Hours Studied", viewMonth.hoursStudied)
                        )
                        .interpolationMethod(.catmullRom)
                        .lineStyle(.init(lineWidth: 3))
                        .foregroundStyle(curGradient)
                    } else {
                        LineMark(
                            x: .value("Month", viewMonth.date, unit: .month),
                            y: .value("Hours Studied", viewMonth.hoursStudied)
                        )
                        .interpolationMethod(.catmullRom)
                        .lineStyle(.init(lineWidth: 3))
                        .foregroundStyle(curGradient)
                    }
                    
                    // Area under line graph: adjust for units
                    if daysToShow <= 31 {
                        AreaMark(x: .value("Day", viewMonth.date, unit: .weekday), y: .value("Hours Studied", viewMonth.hoursStudied))
                            // Curved line
                            .interpolationMethod(.catmullRom)
                            .foregroundStyle(curGradient)
                            .opacity(0.2)
                    } else {
                        AreaMark(x: .value("Month", viewMonth.date, unit: .month), y: .value("Hours Studied", viewMonth.hoursStudied))
                            // Curved line
                            .interpolationMethod(.catmullRom)
                            .foregroundStyle(curGradient)
                            .opacity(0.2)
                    }
                }
            }
            .frame(height: CGFloat(height))
            
            // Make top of graph slightly taller than the highest chart value
            .chartYScale(domain: 0...Float(HistoryChartData.maxMinutesStudied(chartData))*1.5)
            
            // Add "h" to y-axis label values
            .chartYAxis {
                AxisMarks() { value in
                    AxisGridLine()
                    AxisValueLabel {
                        if let number = value.as(Double.self) {
                            Text("\(Int(number))h")
                            
                        }
                    }
                }
            }
            
            // Adjust unit of x-axis labels
            .chartXAxis {
                if daysToShow <= 7 {
                    AxisMarks() { value in
                        AxisGridLine()
                        AxisValueLabel (
                            format: .dateTime.weekday()
                        )
                    }
                } else if daysToShow <= 31 {
                    AxisMarks() { value in
                        AxisGridLine()
                        AxisValueLabel (
                            format: .dateTime.month(.abbreviated).day()
                        )
                    }
                } else {
                    AxisMarks() { value in
                        AxisGridLine()
                        AxisValueLabel (
                            format: .dateTime.month(.abbreviated)
                        )
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    @Previewable @State var daysToShow: Int = 7 // change to see different graph
    @Previewable @State var averageStudyTime: Double = 0
    
    ChartView(daysToShow: $daysToShow, averageStudyTime: $averageStudyTime)
}

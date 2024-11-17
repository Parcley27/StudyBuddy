//
//  ChartView.swift
//  StudyBuddy
//
//  Created by Pierce Oxley on 11/11/24.
//

import SwiftUI
import Charts

func minutesToHoursStudied(_ data: HistoryData) -> (Float) {
    return (Float)(data.minutesStudied)/60.0
}

struct ChartView: View {
    // set height and graph colors for gradient
    var height: Int = 250
    var colors = [Color.purpleSecondary, Color.purplePrimary]
    
    @Binding var daysToShow: Int
    @Binding var averageStudyTime: Double
    // Get data for source
    @Binding var chartData: [HistoryData]
    
    var body: some View {
        // Get properly formatted data
        let chartData: [HistoryData] = HistoryData.formatData(data: chartData, length: daysToShow)
        
        // Color gradient
        let gradient = LinearGradient(
            gradient: Gradient (
                colors: colors
            ),
            startPoint: .leading,
            endPoint: .bottom
        )
        
        VStack {
            Chart {
                ForEach(chartData) { data in
                    // Different x-axis units depending on range
                    if daysToShow <= 7 {
                        LineMark(
                            x: .value("Day", data.date, unit: .weekday),
                            y: .value("Hours Studied", minutesToHoursStudied(data))
                        )
                        .interpolationMethod(.catmullRom)
                        .lineStyle(.init(lineWidth: 3))
                        .foregroundStyle(gradient)
                    } else if daysToShow <= 31 {
                        LineMark(
                            x: .value("Date", data.date, unit: .day),
                            y: .value("Hours Studied", minutesToHoursStudied(data))
                        )
                        .interpolationMethod(.catmullRom)
                        .lineStyle(.init(lineWidth: 3))
                        .foregroundStyle(gradient)
                    } else {
                        LineMark(
                            x: .value("Month", data.date, unit: .month),
                            y: .value("Hours Studied", minutesToHoursStudied(data))
                        )
                        .interpolationMethod(.catmullRom)
                        .lineStyle(.init(lineWidth: 3))
                        .foregroundStyle(gradient)
                    }
                    
                    // Area under line graph: adjust for units
                    if daysToShow <= 31 {
                        AreaMark(x: .value("Day", data.date, unit: .weekday), y: .value("Hours Studied", minutesToHoursStudied(data)))
                            // Curved line
                            .interpolationMethod(.catmullRom)
                            .foregroundStyle(gradient)
                            .opacity(0.2)
                    } else {
                        AreaMark(x: .value("Month", data.date, unit: .month), y: .value("Hours Studied", minutesToHoursStudied(data)))
                            // Curved line
                            .interpolationMethod(.catmullRom)
                            .foregroundStyle(gradient)
                            .opacity(0.2)
                    }
                }
            }
            .frame(height: CGFloat(height))
            
            // Make top of graph slightly taller than the highest chart value
            .chartYScale(domain: 0...Float(HistoryData.maxMinutesStudied(chartData)/60)*1.5)
            
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
    @Previewable @State var daysToShow: Int = 365
    @Previewable @State var averageStudyTime: Double = 0
    
    @Previewable @State var chartData: [HistoryData] = ProfileData.mock.historyData
    
    ChartView(daysToShow: $daysToShow, averageStudyTime: $averageStudyTime, chartData: $chartData)
}
